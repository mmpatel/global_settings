class GlobalSetting < ActiveRecord::Base

  validates :key_name, uniqueness: true, presence: true
  validate :has_valid_key_type

  def value=(obj)
    self.key_type = obj.class.to_s
    write_attribute(:key_value, obj)
    @key_value = obj
  end

  def value
    return @key_value unless @key_value.nil?

    @key_value = case self.key_type.to_s
    when "FalseClass"
      false
    when "Fixnum"
      self.key_value.to_i
    when "Float"
      self.key_value.to_f
    when "NilClass"
      nil
    when "String"
      self.key_value
    when "TrueClass"
      true
    end
  end

  protected
    def has_valid_key_type
      unless self.key_type.nil? || self.value.class.to_s != self.key_type
        errors.add :base, "The class of the key value must be match with key type."
      end
    end
end