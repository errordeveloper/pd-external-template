require ('erb')

## Author's name should be entered
## interactively, or as --authors=
meta = {
  :project => "test1",
  :authors => "John Doe, John Smith",
  :version => "0.01",
  :contact => "<john@example.com>"
};

template = ERB.new <<-EOF
#N canvas 15 49 200 200 10;
#N canvas 25 49 420 300 META 1;
#X text 13 41 NAME <%=meta[:project]%>;
#X text 10 25 AUTHOR <%=meta[:authors]%>
#X text 10 10 VERSION <%=meta[:version]%>;
#X restore 10 10 pd META;
EOF

puts template.result(binding)
