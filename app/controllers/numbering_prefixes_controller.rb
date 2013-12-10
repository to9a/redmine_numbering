class NumberingPrefixesController < ApplicationController
  unloadable

  #メニュー項目を選択状態とする
  menu_item :numbering

  #プロジェクトメニュー配下にするためのおまじない  
  before_filter :find_project, :authorize

  # 一覧画面表示
  def index
    @numbering_categories = NumberingCategory.find(:all)
    @numbering_kinds = NumberingKind.find(:all)
    @numbering_partners = NumberingPartner.find(:all)
  end
  
private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
