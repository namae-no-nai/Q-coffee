<div class="container">
  <div class="row">
    <div class="col-xs-12 col-sm-4 col-sm-offset-4">
      <div class="form-login">
      <h2>Editar review para <%= @coffee.name %></h2>
      <%= simple_form_for [@coffee, @review] do |f| %>
      <%= f.input :content %>
      <%= f.input :rating, collection: (1..5).to_a, label: "Diga o que achou" %>
      <%= f.button :submit, "Enviar" %>
      <% end %>
      </div>
    </div>
  </div>
</div>
