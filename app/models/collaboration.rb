class Collaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :collaborator, class_name: 'User'
  
  def self.collaborators
    User.where(id: pluck(:collaborator_id))
  end

  def self.wikis
    Wiki.where(id: pluck(:wiki_id))
  end

  def wiki
    Wiki.where(id: wiki_id)
  end

  def collaborator
    User.where(id: collaborator_id)
  end
end
