class NumberingPrefixesPartnersController < ApplicationController
  unloadable


 #メニュー項目を選択状態とする
  menu_item :numbering

  #プロジェクトメニュー配下にするためのおまじない  
  before_filter :find_project, :authorize
  before_filter :find_numbering_partners, :except => [:index, :preview]
  before_filter :find_numbering_partner, :except => [:index, :new, :create, :preview]
 
  def index
  end

  def new
    logger.debug("[DEBUG]NumberingPrefixesPartnersController#new")
    @numbering_partner = NumberingPartner.new()
  end

  def create
    logger.debug("[DEBUG]NumberingPrefixesPartnersController#create")
    @numbering_partner = NumberingPartner.new(params[:numbering_prefix])

    if @numbering_partner.save()
      flash[:notice] = l(:notice_successful_create)
      # redirect_to project_numbering_prefixes_partner_path(:id => @numbering_partner.id)
      redirect_to project_numbering_prefixes_path(@project)
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.api  { render_validation_errors(@numbering_partner) }
      end
    end
  end

  def edit
    logger.debug("[DEBUG]NumberingPrefixesPartnersController#edit")
  end

  def update
    logger.debug("[DEBUG]NumberingPrefixesPartnersController#update")

    if @numbering_partner.update_attributes(params[:numbering_prefix])
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_numbering_prefixes_path(@project)
    else
      respond_to do |format|
        format.html { render :action => 'edit' }
        format.api  { render_validation_errors(@numbering_partner) }
      end
    end 
  end

  def destroy
    @numbering_partner.destroy
    # 文書の削除後は一覧表示画面へ遷移 
    redirect_to project_numbering_prefixes_path(@project)
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_partners
    @numbering_partners = NumberingPartner.find(:all)
  rescue ActiveRecord::RecordNotFound
     render_404
  end

  def find_numbering_partner
     @numbering_partner = NumberingPartner.find(params[:id])
  rescue ActiveRecord::RecordNotFound
     render_404
  end
end

