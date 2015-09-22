require "gacha_sample/version"

module GachaSample
  def self.included(base)
    base.class_variable_set(:@@require_gacha_weight_column, :weight)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def set_gacha_weight_column(column)
      self.class_variable_set(:@@require_gacha_weight_column, column)
    end

    def gacha_weight_column
      self.class_variable_get(:@@require_gacha_weight_column)
    end

    def gacha(n=nil, options={})
      column = options[:column] || gacha_weight_column
      is_unique = !!options[:unique]
      records = self.all.sort{|a,b|a.send(column) <=> b.send(column)}
      if n
        Array.new(n).map do
          s = pickup(column, records)
          records.delete(s)  if is_unique
          s
        end.compact
      else
        pickup(column, records)
      end
    end

    private

    def pickup(column, records)
      total   = records.sum(&column)
      index   = rand(total)
      records.inject(0) do |sum, rec| 
        i = sum + rec.send(column)
        return rec if index < i
        i
      end
      return nil
    end

  end
end
