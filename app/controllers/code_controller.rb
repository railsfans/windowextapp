class CodeController < ApplicationController
layout "special"

def code_add
@codeA=Code.find(params[:parent_id].to_i)
@codeB=Code.find(@codeA.parent_id)
@code=@codeB.code+@codeA.code+params[:code]
flag = true
@codes=Code.where(:parent_id=>params[:parent_id])
@codes.each do |code|
if code.code==@code
flag=false
end
end
if flag
Code.create(:name=>params[:name], :parent_id=>params[:parent_id], :code=>@code, :footprint=>params[:footprint], :manufacturer=>params[:manufacturer], :partNum=>params[:partNum], :describe=>params[:describe])
end
respond_to do |format|
	format.json { render :json=>{:success=>flag} }
end
end

def code_edit
@codeA=Code.find(params[:parent_id].to_i)
@codeB=Code.find(@codeA.parent_id)
@codeC=@codeB.code+@codeA.code+params[:code]
flag = true
@codes=Code.where(:parent_id=>params[:parent_id])
@codes.each do |code|
if code.code==@codeC  && code.id != params[:id].to_i
flag=false
end
end
if flag
@code = Code.find(params[:id])
@code.update_attributes(:name=>params[:name], :code=>@codeC, :footprint=>params[:footprint], :manufacturer=>params[:manufacturer], :partNum=>params[:partNum], :describe=>params[:describe])
end
 respond_to do |format|
	format.json { render :json=>{:success=>flag}}
end
end

def code_delete
ids = params[:id].split(/,/)
ids.each do |id|
@code = Code.find(id)
@code.destroy
end
 respond_to do |format|
	format.json { render :json=>{:success=>true}}
end
end
  
def node_add
flag = true
@codes=Code.where(:parent_id=>params[:id])
@codes.each do |code|
if code.code==params[:code]
flag=false
end
end
if flag
Code.create(:name=>params[:name], :parent_id=>params[:id], :code=>params[:code]) 
end
respond_to do |format|
	format.json { render :json=>{:success=>flag} }
end
end 

def node_edit
flag = true
@codes=Code.where(:parent_id=>params[:parent_id])
@codes.each do |code|
if code.code==params[:code]
flag=false
end
end
if flag
@code = Code.find(params[:id])
@code.update_attributes(:name=>params[:name], :code=>params[:code]) 
end
respond_to do |format|
	format.json { render :json=>{:success=>flag} }
end
end 

def node_delete
@code = Code.find(params[:id])
@code.destroy 
respond_to do |format|
	format.json { render :json=>{:success=>true} }
end
end

def get
respond_to do |format|
	format.js
end
end
   
def all
@codes=Code.order("code ASC").where(:parent_id=>params[:parent_id])
respond_to do |format|
	format.json { render json: @codes }
end
end

def lists
if params[:search_type]!='0'
if params[:search_type] == '101100'

if params[:value1].empty? && params[:value2].empty?
@codes = Code.order("code ASC").find(:all, :offset=>params[:start].to_i, :limit=>params[:limit].to_i, :conditions=>{:parent_id=>params[:parent_id]})
if !Code.count.nil? & @codes.empty?
@codes=Code.find(:all, :offset=>(params[:start].to_i-params[:limit].to_i), :limit=>params[:limit].to_i, :conditions=>{:parent_id=>params[:parent_id]})
end
totalCount=2
elsif params[:value1].empty? && !params[:value2].empty?
@codes = Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%") 
#totalCount=Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%").count
totalCount=2
elsif !params[:value1].empty? && params[:value2].empty?
@codes = Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%") 
#totalCount=Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%").count
totalCount=2
else !params[:value1].empty? && !params[:value2].empty?
@codes = Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%").where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%")
#totalCount=Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%").where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%").count
totalCount=2
end

elsif params[:search_type] == '100000'


@codes = Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ? or name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%")
totalCount=Code.where(:parent_id=>params[:parent_id]).where("name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ? or name like ? or code like ? or partNum like ? or footprint like ? or manufacturer like ? or describe like ?","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value1]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%","%#{params[:value2]}%").count


end
else
@codes = Code.order("code ASC").find(:all, :offset=>params[:start].to_i, :limit=>params[:limit].to_i, :conditions=>{:parent_id=>params[:parent_id]})
if !Code.count.nil? & @codes.empty?
@codes=Code.find(:all, :offset=>(params[:start].to_i-params[:limit].to_i), :limit=>params[:limit].to_i, :conditions=>{:parent_id=>params[:parent_id]})
end
totalCount=Code.find(:all, :conditions=>{:parent_id=>params[:parent_id]}).count
end

respond_to do |format|
	format.html # index.html.erb
	format.json { render json: { :totalCount=>totalCount, :gridData=> @codes } }
	format.js 
end
end

def list
respond_to do |format|
	format.js 
end
end

def ajax
respond_to do |format|
	format.html
	format.js
end
end

end
