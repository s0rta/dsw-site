# frozen_string_literal: true

ActiveAdmin.register AnnualSchedule do

  menu parent: 'Site Content', label: 'Schedule'

  permit_params :year,
                :cfp_open_at,
                :cfp_close_at,
                :voting_open_at,
                :voting_close_at,
                :registration_open_at,
                :week_start_at,
                :week_end_at,
                :sponsorship_open_at,
                :sponsorship_close_at,
                :pitch_application_open_at,
                :pitch_application_close_at,
                :pitch_voting_open_at,
                :pitch_voting_close_at,
                :ambassador_application_open_at,
                :ambassador_application_close_at

  index do
    selectable_column
    column :year
    actions
  end

  show(title: :year) do
    attributes_table do
      row :year
      row 'Week' do |r|
        "#{r.week_start_at.to_s(:month_day)} &ndash; #{r.week_end_at.to_s(:month_day)}".html_safe
      end
      row 'CFP' do |r|
        if r.cfp_open_at.present? && r.cfp_close_at.present?
          "#{r.cfp_open_at.to_s(:month_day)} &ndash; #{r.cfp_close_at.to_s(:month_day)}".html_safe
        end
      end
      row 'Voting' do |r|
        if r.voting_open_at.present? && r.voting_close_at.present?
          "#{r.voting_open_at.to_s(:month_day)} &ndash; #{r.voting_close_at.to_s(:month_day)}".html_safe
        end
      end
      row 'Registration' do |r|
        if r.registration_open_at.present?
          "#{r.registration_open_at.to_s(:month_day)} &ndash; #{r.week_end_at.to_s(:month_day)}".html_safe
        end
      end
      row 'Sponsorship' do |r|
        if r.sponsorship_open_at.present? && r.sponsorship_close_at.present?
          "#{r.sponsorship_open_at.to_s(:month_day)} &ndash; #{r.sponsorship_close_at.to_s(:month_day)}".html_safe
        end
      end
      row 'Pitch Application' do |r|
        if r.pitch_application_open_at.present? && r.pitch_application_close_at.present?
          "#{r.pitch_application_open_at.to_s(:month_day)} &ndash; #{r.pitch_application_close_at.to_s(:month_day)}".html_safe
        end
      end
      row 'Pitch Voting' do |r|
        if r.pitch_voting_open_at.present? && r.pitch_voting_close_at.present?
          "#{r.pitch_voting_open_at.to_s(:month_day)} &ndash; #{r.pitch_voting_close_at.to_s(:month_day)}".html_safe
        end
      end
      row 'Ambassador Application' do |r|
        if r.ambassador_application_open_at.present? && r.ambassador_application_close_at.present?
          "#{r.ambassador_application_open_at.to_s(:month_day)} &ndash; #{r.ambassador_application_close_at.to_s(:month_day)}".html_safe
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :year
      f.input :cfp_open_at, as: :datepicker, label: 'CFP Opens'
      f.input :cfp_close_at, as: :datepicker, label: 'CFP Closes'
      f.input :voting_open_at, as: :datepicker, label: 'Voting Opens'
      f.input :voting_close_at, as: :datepicker, label: 'Voting Closes'
      f.input :registration_open_at, as: :datepicker, label: 'Registration Opens'
      f.input :week_start_at, as: :datepicker, label: 'Week Begins'
      f.input :week_end_at, as: :datepicker, label: 'Week Ends'
      f.input :sponsorship_open_at, as: :datepicker, label: 'Sponsorship Opens'
      f.input :sponsorship_close_at, as: :datepicker, label: 'Sponsorship Closes'
      f.input :pitch_application_open_at, as: :datepicker, label: 'Pitch Contest Applications Open'
      f.input :pitch_application_close_at, as: :datepicker, label: 'Pitch Contest Applications Close'
      f.input :pitch_voting_open_at, as: :datepicker, label: 'Pitch Contest Voting Opens'
      f.input :pitch_voting_close_at, as: :datepicker, label: 'Pitch Contest Voting Closes'
      f.input :ambassador_application_open_at, as: :datepicker, label: 'Ambassador Applications Open'
      f.input :ambassador_application_close_at, as: :datepicker, label: 'Ambassador Applications Close'
    end

    f.actions
  end
end
