task :teste do
	if Teste.all.count < 3
		
		Teste.create
	end
end