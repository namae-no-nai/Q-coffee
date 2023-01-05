<% if @reviews.any? %>
  <div class="container">
    <h2> Todas as Avaliações </h2>
    <% @reviews.each do |review| %>
      <h5><%= review.content %></h5>
      <p><%= "⭐" * review.rating %></p>
    <% end %>
  </div>
<% end %>
