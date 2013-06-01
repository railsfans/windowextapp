class GirlsController < ApplicationController
  # GET /girls
  # GET /girls.json
  layout false
  def index
    if params[:search_type]!='0'
    if params[:search_type] == '101100'
    @girls = Girl.find(:all, :conditions => ["name like ?","%#{params[:value]}%"])
    totalCount=Girl.find(:all, :conditions => ["name like ?","%#{params[:value]}%"]).count
    elsif params[:search_type] == '100000'
    @girls = Girl.find(:all,  :conditions => ["email like ?","%#{params[:value]}%"])
    totalCount=Girl.find(:all, :conditions =>["email like ?","%#{params[:value]}%"]).count
    else
    @girls = Girl.find(:all,  :conditions => ["phone like ?","%#{params[:value]}%"])
    totalCount=Girl.find(:all, :conditions =>["phone like ?","%#{params[:value]}%"]).count
    end
    else
    @girls = Girl.find(:all, :offset=>params[:start].to_i, :limit=>params[:limit].to_i)
    if !Girl.count.nil? & @girls.empty?
    @girls=Girl.find(:all, :offset=>(params[:start].to_i-params[:limit].to_i), :limit=>params[:limit].to_i)
    end
    totalCount=Girl.count
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { :totalCount=>totalCount, :gridData=> @girls } }
      format.js
    end
  end

  def try
  @girls = Girl.find(:all, :offset=>params[:start].to_i, :limit=>params[:limit].to_i)
  respond_to do |format|
  	 format.json { render json: { :totalCount=>Girl.count, :gridData=> @girls } }
  	end
  end
  
  def girl_search
  if(params[:search_type]=='101100')
  @girls=Girl.find(:all, :offset=>params[:start].to_i, :limit=>params[:limit], :conditions=>["name like ?","%#{params[:value]}%"])
	end
	respond_to do |format|
  	 format.json { render json: { :totalCount=>Girl.find(:all, :offset=>params[:start].to_i, :limit=>params[:limit], :conditions=>["name = ?","%#{params[:value]}%"]).count, :gridData=> @girls } }
  	end
	end
  
  def girl_add
  Girl.create(:name=>params[:name], :email=>params[:email], :phone=>params[:phone])
  respond_to do |format|
  	format.json { render :json=>{:success=>true} }
  end
  end

  def girl_edit
  @girl = Girl.find(params[:id])
  @girl.update_attributes(:name=>params[:name], :email=>params[:email], :phone=>params[:phone])
   respond_to do |format|
  	format.json { render :json=>{:success=>true}}
  end
  end
  
  def girl_delete
  @girl = Girl.find(params[:id])
  @girl.destroy
   respond_to do |format|
  	format.json { render :json=>{:success=>true}}
  end
  end

  # GET /girls/1
  # GET /girls/1.json
  def show
    @girl = Girl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @girl }
    end
  end

  # GET /girls/new
  # GET /girls/new.json
  def new
    @girl = Girl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @girl }
    end
  end

  # GET /girls/1/edit
  def edit
    @girl = Girl.find(params[:id])
  end

  # POST /girls
  # POST /girls.json
  def create
    @girl = Girl.new(params[:girl])

    respond_to do |format|
      if @girl.save
        format.html { redirect_to @girl, notice: 'Girl was successfully created.' }
        format.json { render json: @girl, status: :created, location: @girl }
      else
        format.html { render action: "new" }
        format.json { render json: @girl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /girls/1
  # PUT /girls/1.json
  def update
    @girl = Girl.find(params[:id])

    respond_to do |format|
      if @girl.update_attributes(params[:girl])
        format.html { redirect_to @girl, notice: 'Girl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @girl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /girls/1
  # DELETE /girls/1.json
  def destroy
    @girl = Girl.find(params[:id])
    @girl.destroy

    respond_to do |format|
      format.html { redirect_to girls_url }
      format.json { head :no_content }
    end
  end
end
