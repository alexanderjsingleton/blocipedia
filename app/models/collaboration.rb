class Collaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user
  
  def self.collaborators
    User.where(id: pluck(:user_id))
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
