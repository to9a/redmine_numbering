class NumberingPrefixesKindsController < ApplicationController
  unloadable

  #メニュー項目を選択状態とする
  menu_item :numbering

  #プロジェクトメニュー配下にするためのおまじない  
  before_filter :find_project, :authorize
  before_filter :find_numbering_kinds, :except => [:index, :preview]
  before_filter :find_numbering_kind, :except => [:index, :new, :create, :preview]
 
  def index
  end

  def new
    logger.debug("[DEBUG]NumberingPrefixesKindsController#new")
    @numbering_kind = NumberingKind.new()
  end

  def create
    logger.debug("[DEBUG]NumberingPrefixesKindsController#create")
    @numbering_kind = NumberingKind.new(params[:numbering_prefix])

    if @numbering_kind.save()
      flash[:notice] = l(:notice_successful_create)
      # redirect_to project_numbering_prefixes_category_path(:id => @numbering_kind.id)
      redirect_to project_numbering_prefixes_path(@project)
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.api  { render_validation_errors(@numbering_kind) }
      end
    end
  end

  def edit
    logger.debug("[DEBUG]NumberingPrefixesKindsController#edit")
  end

  def update
    logger.debug("[DEBUG]NumberingPrefixesKindsController#update")

    if @numbering_kind.update_attributes(params[:numbering_prefix])
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_numbering_prefixes_path(@project)
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.api  { render_validation_errors(@numbering_kind) }
      end
    end 
  end

  def destroy
    @numbering_kind.destroy
    # 文書の削除後は一覧表示画面へ遷移 
    redirect_to project_numbering_prefixes_path(@project)
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_kinds
    @numbering_kinds = NumberingKind.find(:all)
  rescue ActiveRecord::RecordNotFound
     render_404
  end

  def find_numbering_kind
     @numbering_kind = NumberingKind.find(params[:id])
  rescue ActiveRecord::RecordNotFound
     render_404
  end
end
