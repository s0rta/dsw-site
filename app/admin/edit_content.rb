ActiveAdmin.register_page 'Edit Content' do
   controller do
     define_method(:index) do
       redirect_to '/editor'
     end
   end
 end
