# Quiz 2 
Instructions:
Using the wireframe you see below, implement the following:

1- Implement the ability to display the form and submit a support request as displayed in the wireframe (30%)

2- Implement the ability to edit / delete / list all the support requests in a table  (30%)

3- Implement the ability to mark a support request as `done` or `undone`. All support requests should default to `undone` which should be listed first. (10%)

4- Implement the ability to search support requests (search is wildcard search by name / email / department and message). The search must be case insensitive. (10%)

5- Implement the ability to paginate all support requests (7 requests per page). Make your seed file generates 1000 support requests (Hint: consider using the Faker gem to generate data and Kaminari gem to implement pagination). (10%)

6- Get the pagination and search to work together. So if you search for a term that has more than 7 results it should paginate within the search results and the search term should still show in the search box (10%)

Bonus 1: Write a SQL query that returns a sorted list of the departments and the number of support requests per each department (doesn't have to be inside your Rails app). (10%)

To submit the quiz, have the project hosted on Github and submit the link on Certified.in.

![alt-text](https://s3.amazonaws.com/codecore-website-data/certifiedin_images/CodeCore-Bootcamp-Quiz-1.png)

----
` $ rails new quiz2_redo -d postgresql -T `

The Model
` $ rails g model name email department message:text status:boolean`

The Controller
=======
### Create a new rails app: 
` $ rails new quiz2_redo -d postgresql -T `<br>
` $ bundle `

### Create the model:
` $ rails db:create`<br>
` $ rails g model support_request name email department message:text status:boolean`<br>
` $ rails db:migrate`<br>

### Create the controller:
we generate the `SupportRequestsController` where we will put all the actions for the CRUD<br>
` $ rails g controller support_requests`<br>

--> in gemfile, to see our data in a table format in rails c, we use the gem hirb
under `group :development do`
```
  gem 'hirb'
  gem 'interactive_editor'
  gem 'awesome_print'

```
### NEW Action<br>
--> in routes.rb
```rb
resources :support_requests

root 'support_requests#index`
```
--> in support_requests_controller.rb:
```rb
  def new
    @support_request = SupportRequest.new
  end
```
--> in app/views/support_requests, create `_form.html.erb`, `new.html.erb`
--> in _form.html.erb
```erb
<%= form_for @support_request do |f| %>
<div>
  <%= f.label :name %>
  <%= f.text_area :name %>
</div>

<div>
  <%= f.label :email %>
  <%= f.text_area :email %>
</div>

<div>
  <%= f.label :department, "Department" %>
  <%= f.radio_button :department, "Sales" %>
  <%= f.label:dep_sales, "Sales" %>
  <%= f.radio_button :department, "Marketing" %>
  <%= f.label :dept_marketing, "Marketing" %>
  <%= f.radio_button :department, "Technical" %>
  <%= f.label :dept_technical, "Technical" %>
</div>

<div>
  <%= f.label :message %></br>
  <%= f.text_area :message %>
</div>
<%= f.submit %>
<% end %>
```

### CREATE Action
--> in _form.html.erb, if the form doesn't show any errors, we can add that to our app:
```rb
<% if @support_request.errors.any? %>
  <ul>
    <% @support_request.errors.full_message.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
  </ul>
<% end %>

<%= form_for @support_request do |f| %>
  <div>
  ....
```
### SHOW Action
--> in support_requests_controller.rb, we want to show the detailed data by finding the params by their ID
```rb
  def show
    @support_requests = SupportRequest.find params[:id]
  end
```
--> in views/support_requests, create `show.html.erb`
```erb
<h2>View Support Request</h2>

<p><strong>Name:</strong> <%= @support_requests.name %><br>
   <strong>Email:</strong> <%= @support_requests.email %><br>
   <strong>Department:</strong> <%= @support_requests.department %>
</p>
<p><strong>Message:</strong> <%= @support_requests.message %></p>
```

### INDEX Action
--> in support_requests_controller.rb
```rb

```
### EDIT ACTION
--> in support_requests_controller.rb
```rb
```
--> in views/support_requests, create `edit.html.erb`
```rb
<h1>Edit a Support Request </h1>
  <%= render "form" %>
```
### UPDATE Action
--> in routes.rb
```rb
  get '/requests/update/:id' => 'requests#index', as: :update_support_request
  post "/requests/:search" => "requests#index", as: :search_support_request
```
-->

### DESTROY
--> in support_requests_controller.rb
```rb
  def destroy
    support_request = SupportRequest.find params[:id]
    support_request.destroy
    redirect_to support_requests_path
    flash[:alert] = "Support Request deleted!"
  end
```
--> in index.html.erb
```erb
  <%= link_to "Delete", support_request_path(x), method: :delete, data: {confirm: "Are you sure you want to delete this support request?"} %>
```



## SEEDING THE DATABASE
--> in gemfile, under `group :development do`:
```
 gem 'faker', github: 'stympy/faker'
```
--> seeds.rb
```rb
choices = ["marketing", "sales", "technical"]
1000.times do
  support_request = SupportRequest.new( name: Faker::Name.name,
                                email: Faker::Internet.email,
                                department: choices.sample,
                                message: Faker::Hacker.say_something_smart)
  support_request.save
end
```
```
$ rails db:seed
```



### DONE/ NOT DONE BUTTON
--> in support_requests_controller.rb
```rb
def index

end
```
we need to set the default status as false: 
--> in support_request.rb
```rb
  after_initialize :set_status_default

  def set_status_default
    self.status ||= false
  end
```

### PAGINATION
--> in gemfile
```
gem 'kaminari'
```
--> in support_requests.rb
```rb
  paginates_per 7
```
--> in support_requests_controller.rb
```rb
  REQUESTS_PER_PAGE = 7
  before_action :find_request, only: [:edit, :update, :destroy]
```
define find_request under a private method
```rb
private

  def find_request
    @support_request = SupportRequest.find params[:id]
  end

```

--> in index.html.erb
```erb

<%= paginate @support_request %>
```

### SEARCH
--> in routes.rb, create the search path:
```rb

```
--> in index.html.erb, create the search bar:
```erb

```



rails g migration add_default_value_to_support_requests


--> in migration file
```rb
  def change
    change_column_default :support_requests, :status, false
  end
```

