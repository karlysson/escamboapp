def levantar_erro
    begin
        puts "Antes do erro"
        File.open("abc.txt")
        puts "Depois do erro"
    rescue Exception => e
        puts "pode dar o erro eu continuo...#{e}"
    ensure
        puts "independe de qualquer coisa eu rodo."
    end
end

levantar_erro
