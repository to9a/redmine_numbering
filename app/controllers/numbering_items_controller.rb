class NumberingItemsController < ApplicationController
  unloadable

  #メニュー項目を選択状態とする
  menu_item :numbering

  #プロジェクトメニュー配下にするためのおまじない  (初期処理)
  before_filter :find_project, :authorize
  before_filter :find_numbering_item, :except => [:index, :new, :create, :preview]

  def index
    logger.debug("[DEBUG]NumberingItemsController#index")
    @numbering_items = NumberingItem.find(:all, :order => "created_on DESC")
    numbering_categories = NumberingCategory.find(:all)
    numbering_kinds = NumberingKind.find(:all)
    numbering_partners = NumberingPartner.find(:all)
    @categories_disp_name = numbering_categories.map(&:disp_name);
    @kinds_disp_name = numbering_kinds.map(&:disp_name);
    @partners_disp_name = numbering_partners.map(&:disp_name);
    @categories_identifier = numbering_categories.map(&:identifier);
    @kinds_identifier = numbering_kinds.map(&:identifier);
    @partners_identifier = numbering_partners.map(&:identifier);
  end

  def new
    logger.debug("[DEBUG]NumberingItemsController#new")
    @numbering_item = NumberingItem.new()
  end

  def create
    logger.debug("[DEBUG]NumberingItemsController#create")
    @numbering_item = NumberingItem.new(params[:numbering_item])
    # 番号設定 (年単位の通し番号)
    publish_year = Time.now.year.to_s + "%"
    # publish_year_document = NumberingItem.find(:all, :conditions => ["created_on like ?", publish_year])
    # @numbering_item.number = publish_year_document.count + 1
    publish_year_document_num = NumberingItem.maximum('number', :conditions => ["created_on like ?", publish_year])
    # logger.debug("[DEBUG]NumberingItemsController#create:publish_year_document=#{publish_year_document_num}")    
    @numbering_item.number = publish_year_document_num.to_i + 1

    # 発行者名を設定
    @numbering_item.publisher = User.find(User.current).name

    if @numbering_item.save()
      flash[:notice] = l(:notice_successful_create)
      redirect_to project_numbering_item_path(:id => @numbering_item.id)
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.api  { render_validation_errors(@numbering_item) }
      end
    end
  end

  def show
    logger.debug("[DEBUG]NumberingItemsController#show")
    @numbering_category = NumberingCategory.find(@numbering_item.numbering_category_id);
    @numbering_kind = NumberingKind.find(@numbering_item.numbering_kind_id);
    @numbering_partner = NumberingPartner.find(@numbering_item.numbering_partner_id);
    
    # 採番文字列を成型する(カテゴリ/種別/提出先/発行年(下2桁)/発行番号(3桁0パディング)
    @numbering_number = @numbering_category.identifier + 
                        @numbering_kind.identifier + 
                        @numbering_partner.identifier +
                        @numbering_item.created_on.to_s[2,2] + 
                        format("%03d", @numbering_item.number)    
#    logger.debug("[DEBUG]NumberingItemsController#show:@numbering_number=#{@numbering_number}")
  end

  def edit
    logger.debug("[DEBUG]NumberingItemsController#edit")
  end

  def update
    logger.debug("[DEBUG]NumberingItemsController#update")

    if @numbering_item.update_attributes(params[:numbering_item])
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_numbering_item_path(:id => @numbering_item.id)
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.api  { render_validation_errors(@numbering_item) }
      end
    end 
  end

  def destroy
    @numbering_item.destroy
    # 文書の削除後は一覧表示画面へ遷移 
    redirect_to project_numbering_items_path(@project)
  end
private
  def find_project
    @project = Project.find(params[:project_id])

    #　終了していないプロジェクトを作成日が新しい順に取得する
    @active_project = Project.find(:all, :conditions => {:status => 1}, :order => "created_on DESC")
    logger.debug("[DEBUG]NumberingItemsController#find_project:@active_project=#{@active_project}")
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_item
     @numbering_item = NumberingItem.find(params[:id])
  rescue ActiveRecord::RecordNotFound
     render_404
  end
end
