class InvatationController < ApplicationController
  def index
  end

  def find_guest
    @guest = Guest.where(phone_number: params[:phone_number]).includes(:co_guests)
  end

  def rsvp
    has_changes = params[:has_changes]
    if(has_changes)
      @guest.update(guest_params)
    else
      confirmations = params[:confirmations]
      confirmations.each do |guest_id, confirmed|
        guest = Guest.find(guest_id)
        guest.confirmed = confirmed
        guest.save
      end
    end
    render :thank_you, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @test = Test.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guest_params
      params.fetch(:guest, {:name, :lastname, :email, :confirmed})
    end
end
