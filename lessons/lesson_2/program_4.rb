# Русский алфавит

alphabet_ru = ['а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я'] # Для русского алфавита было сделано полное перечилсение, так как при использовании Range, буква 'ё' не входит в список
vowels_ru = ['а', 'о', 'у', 'ы', 'э', 'е', 'ё', 'и', 'ю', 'я']
h_ru = {}
alphabet_ru.each do |letter_ru|
  if vowels_ru.include?(letter_ru)
    h_ru[letter_ru.to_sym] = alphabet_ru.index(letter_ru) + 1
  end
end

puts h_ru

# Английский алфавит

alphabet_eng = ('a'..'z').to_a
vowels_eng = ['a', 'e', 'i', 'o', 'u', 'y']
h_eng = {}
alphabet_eng.each do |letter_eng|
  if vowels_eng.include?(letter_eng)
    h_eng[letter_eng.to_sym] = alphabet_eng.index(letter_eng) + 1
  end
end

puts h_eng