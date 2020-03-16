class Admin::BudgetPhasesController < Admin::BaseController
  include Translatable
  include ImageAttributes

  before_action :load_phase, only: [:edit, :update]

  def edit
  end

  def update
    if @phase.update(budget_phase_params)
      notice = t("flash.actions.save_changes.notice")
      redirect_to edit_admin_budget_path(@phase.budget), notice: notice
    else
      render :edit
    end
  end

  private

    def load_phase
      @phase = Budget::Phase.find(params[:id])
    end

    def budget_phase_params
      valid_attributes = [:starts_at, :ends_at, :enabled,
                          :main_link_url,
                          image_attributes: image_attributes]
      params.require(:budget_phase).permit(*valid_attributes, translation_params(Budget::Phase))
    end
end
