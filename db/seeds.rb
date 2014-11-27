IoAsk::Topic.create(:title => 'test title1')
IoAsk::Topic.create(:title => 'test title2')

ask_root_category = IoAsk.category_class.create(:name => 'Ask')
IoAsk.category_class.create(:name => 'test c1', :parent => ask_root_category)
IoAsk.category_class.create(:name => 'test c2', :parent => ask_root_category)