class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy add_member remove_member ]
  before_action :set_participant, only: %i[ add_member remove_member ]
  after_action :add_member, only: %i[ create ]

  def make_owner!(user)
    @membership = group_participations.where(user_id: user.id).first
    @membership.owner = true
    @membership.save
  end

  def add_member
    GroupParticipation.create!(group: @group, user: @participant, join_date: DateTime.current)
  end

  def remove_member
    GroupParticipation.destroy_by(group: @group, user: @participant)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @posts = Post.where(user_id: [@group.participant_ids]).order(created_at: :desc)
  end

  # GET /groups/new
  def new
    @group = current_user.groups.build
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = current_user.groups.new(group_params)
    @participant = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to feed_path, notice: "Group was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.expect(group: [ :name, :avatar, :bio, :header ])
    end

    def set_participant
      @participant = User.find_by(username: params[:participant])
    end
end
