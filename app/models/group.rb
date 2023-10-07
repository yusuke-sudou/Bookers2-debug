class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
  
  def get_group_image　
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end
  # このメソッドはgroup_imageがアタッチ（存在）しているかチェックしている。
  # group_imageがアタッチされていれば返され、されていなければno_image.jpgと文字列が返される。
  
  def is_owned_by?(user)
    owner.id == user.id
  end
  # この部分は引数のuserがgroupの作成者か調べるメソッド。
  # groupの作成者のみgroupの編集画面を表示させるときに使用。
  
end
