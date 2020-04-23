json.extract! surgical_service, :id, :user_id, :or_schedule_id, :post_schedule_status, :reason_for_cancellation, :or_table_id, :anesthesia_time, :incision_time, :surgery_end_time, :surgical_safety_checklist_completed, :immediate_postoperative_outcome, :reason_for_death, :created_at, :updated_at
json.url surgical_service_url(surgical_service, format: :json)
