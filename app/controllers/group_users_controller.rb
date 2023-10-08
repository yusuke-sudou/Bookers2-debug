class GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer
  end

  # グループに参加するためにgroup_usersという中間テーブルにユーザーとグループの関連を作成させるcreateアクション
  # current_userを使用して、現在のユーザーを取得し、group_usersに.newメソッドで新しいレコードを作成、その際にgroup_idを渡してどのグループに参加するかを指定している。
  # group_userオブジェクトを保存し、redirect_to request.refererで前にいたページに戻る。

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end

  # 現在ログインしているユーザーがグループから退会するためのdestroyアクション
  # ログインしているユーザーのgroup_users関連付けを使用して、指定したグループに関連付けられたgroup_userインスタンスをfind_byメソッドで検索
  # destroyメソッドでgroup_userを削除し、redirect_to request.refererで前にいたページに戻る。

end
