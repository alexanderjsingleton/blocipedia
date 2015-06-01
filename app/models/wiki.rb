class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, class_name: 'User'
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :collaborator

  def owner
    User.where(id: owner_id)
  end

  def collaborations
    Collaboration.where(wiki_id: id)
  end

  def collaborators
    collaborations.collect(&:user)
  end
end
