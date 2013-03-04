#Drink model for all drink items
class DrinkMenu < ActiveRecord::Base
  attr_accessible :category, :name, :price

  def self.for_cat(cat)
    return unless cat
    self.where(category: cat)
  end

  def self.avail_categories
    self.all.map {|a| a.category }.uniq
  end

  def self.hashed_response
    hash_resp = {}
    avail_categories.each do |cat|
      cat_sym = cat.gsub(" ", "_").to_sym
      hash_resp.merge!({
        cat_sym => names_for_cat(for_cat(cat))
        })
    end
    hash_resp
  end

private

  def self.names_for_cat(collection)
    return unless collection
    collection.map {|a| a.name}
  end

end
