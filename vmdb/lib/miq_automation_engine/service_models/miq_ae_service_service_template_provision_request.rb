module MiqAeMethodService
  class MiqAeServiceServiceTemplateProvisionRequest < MiqAeServiceMiqRequest
    def ci_type
      'service'
    end

    def user_message=(msg)
      ar_method { object_send(:update_attribute, :options, {:user_message => msg} ) }
    end
  end
end
