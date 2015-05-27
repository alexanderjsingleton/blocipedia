class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :owned_wikis, class_name: 'Wiki', foreign_key: 'owner_id'
  has_many :collaborations, foreign_key: 'collaborator_id'
  has_many :collaborated_wikis, through: :collaborations, source: :wiki
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

   def admin?
     role == 'admin'
   end
   
   def moderator?
     role == 'moderator'
   end

  def owned_wikis
    Wiki.where(owner_id: id)
  end

  def collaborations
    Collaboration.where(collaborator_id: id)
  end

  def collaborated_wikis
    collaborations.wikis
  end
   
end
