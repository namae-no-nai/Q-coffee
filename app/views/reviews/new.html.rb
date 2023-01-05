<div class="container">

  <%= simple_form_for [@coffee, @review] do |f| %>
  <%= f.input :content %>
  <%= f.input :rating %>
  <%= f.submit class: 'btn btn-primary' %>
  <% end %>
</div>
