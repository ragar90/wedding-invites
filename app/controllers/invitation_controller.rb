class InvitationController < ApplicationController
  def index
    @country_codes = {"El Salvador" => "+503", "Estados Unidos" => "+1", "Panama" => "+507", "Australia" => "+61", "Guatemala" => "+502"}
  end

  def find_guest
    phone_number = "#{params[:country_code]}#{params[:number]}"
    @guest = Guest.where(phone_number: phone_number).includes(:co_guests).first
    if @guest
      render :show
    else
      render :not_found, status: :not_found
    end
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
      params.require(:guest).permit(:name, :lastname, :email, :confirmed)
    end
end
