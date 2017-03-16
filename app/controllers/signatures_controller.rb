class SignaturesController < ApplicationController
  before_action :set_signature, only: [:destroy]

  def new
    @signature = Signature.new
  end

  def create 

  end

  def destroy

  end

  private
    def set_signature
      @signature = Signature.find(params[:id])
    end

    def signature_params
      params.require(:signature).permit(:name, :signature, :jig_work_order_id, :kind)  
    end
end
