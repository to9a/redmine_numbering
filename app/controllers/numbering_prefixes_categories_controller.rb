class NumberingPrefixesCategoriesController < ApplicationController
  unloadable

  #メニュー項目を選択状態とする
  menu_item :numbering

  #プロジェクトメニュー配下にするためのおまじない  
  before_filter :find_project, :authorize
  before_filter :find_numbering_categories, :except => [:index, :preview]
  before_filter :find_numbering_category, :except => [:index, :new, :create, :preview]
 
  def index
  end

  def new
    logger.debug("[DEBUG]NumberingPrefixesCategoriesController#new")
    @numbering_category = NumberingCategory.new()
  end

  def create
    logger.debug("[DEBUG]NumberingPrefixesCategoriesController#create")
    @numbering_category = NumberingCategory.new(params[:numbering_prefix])

    if @numbering_category.save()
      flash[:notice] = l(:notice_successful_create)
      # redirect_to project_numbering_prefixes_category_path(:id => @numbering_category.id)
      redirect_to project_numbering_prefixes_path(@project)
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.api  { render_validation_errors(@numbering_category) }
      end
    end
  end

  def edit
    logger.debug("[DEBUG]NumberingPrefixesCategoriesController#edit")
  end

  def update
    logger.debug("[DEBUG]NumberingPrefixesCategoriesController#update")

    if @numbering_category.update_attributes(params[:numbering_prefix])
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_numbering_prefixes_path(@project)
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.api  { render_validation_errors(@numbering_category) }
      end
    end 
  end

  def destroy
    @numbering_category.destroy
    # 文書の削除後は一覧表示画面へ遷移 
    redirect_to project_numbering_prefixes_path(@project)
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_categories
    @numbering_categories = NumberingCategory.find(:all)
  rescue ActiveRecord::RecordNotFound
     render_404
  end

  def find_numbering_category
     @numbering_category = NumberingCategory.find(params[:id])
  rescue ActiveRecord::RecordNotFound
     render_404
  end
end
