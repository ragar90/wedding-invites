class InvitationController < ApplicationController
  before_action :set_guest, only: [:edit, :update]
  def index
    @country_codes = {"El Salvador" => "+503", "Estados Unidos" => "+1", "Panama" => "+507", "Australia" => "+61", "Guatemala" => "+502"}
  end

  def edit
  end

  def update
    @guest.update(guest_params)
    render :show, main_guest: @guest
  end

  def find_guest
    phone_number = "#{params[:country_code]}#{params[:number]}"
    @guest = Guest.where(phone_number: phone_number).includes(:co_guests).first
    if @guest
      render :show, status: :ok
    else
      render :not_found, status: :not_found
    end
  end

  def rsvp
    # confirmations = params[:confirmations]
    # confirmations.each do |guest_id, confirmed|
    #   guest = Guest.find(guest_id)
    #   guest.confirmed = confirmed
    #   guest.save
    # end
    rsvps = params.select{|k, v| k.to_s.include?("confirm_")}
    confirm_guest_ids = rsvps
      .keep_if{|k, v| k.to_s.include?("confirm_")}
      .keys.map{|k| k.split("confirm_")[1].to_i}
    not_attending_guest_ids = params[:guest_ids]
      .split(",")
      .select{|id| !confirm_guest_ids.include?(id.to_i)}
    Guest.where(id: confirm_guest_ids).update_all(status: Guest.statuses[:confirmed])
    Guest.where(id: not_attending_guest_ids).update_all(status: Guest.statuses[:not_attending])
    render :thank_you, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guest_params
      params.require(:guest).permit(permitted_params, co_guests_attributes: permitted_params)
    end

    private

      def permitted_params
        [:name, :lastname, :email, :status, :id]
      end
end
