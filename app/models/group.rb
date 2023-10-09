class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  
  has_many :users, through: :group_users, source: :user
   # groupモデルがgroup_userモデルを通してuserモデルと関係していることを表す。

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

  def includesUser?(user) # 与えられたユーザーがグループのメンバーであるかどうか判定するメソッド
    group_users.exists?(user_id: user.id)
  end  
  # group_userテーブルからuser_idがuserのidと一致するレコードが存在するかどうかをチェック、存在する場合はtrue、存在しない場合はfalseで返す。
end
