class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]


  def index
    @items = Item.all
  end

  def show
  end


  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def total_result
    @items=params[:item_ids]
    @subtotal=[]
    @items.each do |itm|
      @subtotal << Item.where(id: itm).first.rate
    end
    @subtotal.inspect
    sum(@subtotal)
    @result=[]
    @final=0
    params[:item_ids].each do |it|
      item=Item.where(id: it).first
      rate=item.rate
      item_tax_record=item.item_tax
      tax=item_tax_record.tax
      if item_tax_record.tax_type=="Percentage"
        @tax = ((tax/100)*rate).to_i
        @final=@final+@tax
      else
        @tax = item_tax.rate+tax
        @final=@final+@tax
      end
    end
  end

  def sum(subtotal)
    @results=subtotal.inject(0) { |sum, num| sum + num }
  end

  def tax_sum(rs)
    s=0
    rs.each {|c| s=s+c }
    @result=s
  end


  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :rate, :item_category_id, :select)
  end
end
