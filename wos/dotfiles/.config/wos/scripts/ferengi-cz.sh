# Skript který náhodně ukáže jedno Ferngské pravidlo zisku
# autor: weakCZ

# Samotná pravidla
#
#   První sloupec je číslo pravidla
#     některá pravidla mají stejné číslo, protože různé zdroje pod stejným číslem uvádějí různá pravidla
#     proto jsem se rozhodl sem dát všechny i když mají stejné číslo
#
#   Druhý sloupec je samotný text pravidla
#
#   Komentář za pravidly je anglický originál

rules=(
    "0" "Vždy poslechni Velkého Naguse"                                                       # "Always listen to the Grand Nagus" 
    "1" "Jak máš jednou jejich peníze, nikdy jim je nevracej."                                # "Once you have their money, you never give it back."
    "2" "Nejlepší obchod je ten, který prínáši největší zisk"                                 # "The best deal is the one that brings the most profit."
    "3" "Nikdy za akvizici neutrať víc, než musíš."                                           # "Never spend more for an acquisition than you have to."
    "4" "Nepokoje a vzpoura vždy přináší zisk"                                                # "Sedition and treason are always profitable."
    "5" "Vždy přežeň svůj odhad"                                                              # "Always exaggerate your estimates."
    "6" "Nedopusť aby ti rodina stála v cestě za ziskem"                                      # "Never allow family to stand in the way of opportunity."
    "7" "Měj uši nastražené"                                                                  # "Keep your ears open."
    "8" "Drobné písmo vede k velkému zisku"                                                   # "Small print leads to large risk."
    "9" "Příležitost plus instinkt rovná se zisk"                                             # "Opportunity plus instinct equals profit."
   "10" "Chamtiovost je věčná"                                                                # "Greed is eternal."
   "13" "Cokoliv děláš, dělej to pro zisk"                                                    # "Anything worth doing is worth doing for money."
   "14" "Někdy nejrychlejší cesta k zisku je, když tě zisk najde sám"                         # "Sometimes the quickest way to find profits is to let them find you."
   "15"	"Mrtvý člověk neuzavře obchod"                                                        # "Dead men close no deals."
   "16" "Obchod je obchod"                                                                    # "A deal is a deal."
   "17" "Smlouva je smlouva, ale jenom mezi ferengi"                                          # "A contract is a contract is a contract… but only between Ferengi."
   "18" "Fereng bez zisku není Fereng"                                                        # "A Ferengi without profit is no Ferengi at all."
   "19"	"Spokojenost není zaručena"                                                           # "Satisfaction is not guaranteed."
   "20"	"Kdo se schová pod stolem, dočká se zítřejšího zisku"                                 # "He who dives under the table today lives to profit tomorrow."
   "21" "Nikdy neupřednosti přátelství před ziskem"                                           # "Never place friendship above profit."
   "22" "Moudrý člověk uslyší zisk ve větru"                                                  # "A wise man can hear profit in the wind."
   "23" "Nic není důležitějšího než zdraví...kromě peněz"                                     # "Nothing is more important than your health… except for your money."
   "27"	"Není nic nebezpečnějšího než upřímný obchodník"                                      # "There's nothing more dangerous than an honest businessman."
   "29" "Co z toho bud mít já?"                                                               # "What's in it for me?"
   "30"	"Mlčenlivost rovná se získ"                                                           # "Confidentiality equals profit."
   "31" "Nikdy si nedělej srandu z matky Fernga"                                              # "Never make fun of a Ferengi's mother. "
   "33" "Nikdy neuškodí podlézat šéfovi"                                                      # "It never hurts to suck up to the boss."
   "34" "Válka je dobrá pro obchod"                                                           # "War is good for business."
   "35" "Mír je dobrý pro obchod"                                                             # "Peace is good for business."
   "37"	"Kdo investuje brzy získá nejvyšší úrok"                                              # "The early investor reaps the most interest."
   "39"	"Neříkej zákazníkovi víc, než je třeba"                                               # "Don't tell customers more than they need to know."
   "40"	"Žena se může dotýkat tvých lalůčků, ale nikdy tvého latinia"                         # "She can touch your lobes but never your latinum."
   "41"	"Zisk je odměnou sám o sobě"                                                          # "Profit is its own reward."
   "43"	"Živ svou chamtivost, ale neudus ji"                                                  # "Feed your greed, but not enough to choke it."
   "44"	"Nikdy nezaměňuj fištrón a kliku"                                                     # "Never confuse wisdom with luck."
   "45" "Rozšiřuj obchod nebó zemři"                                                          # "Expand or die."
   "47" "Nevěř člověku, co má lepší oblek než ty"                                             # "Don't trust a man wearing a better suit than your own."
   "48" "Čím větší úsměv, tím ostřejší nůž"                                                   # "The bigger the smile, the sharper the knife."
   "51" "Každého, kdo ti přidá na zisku, odměň tak, aby v tom pokračoval."                    # "Reward anyone who adds to your profits so they will continue to do so."
   "52"	"Proč žádat, když můžeš vzít"                                                         # "Never ask when you can take."
   "53"	"Nikdy nevěř nikomu, kdo je větší než ty"                                             # "Never trust anybody taller than you."
   "54"	"Sazba dělená časem se rovná zisku"                                                   # "Rate divided by time equals profit."
   "55"	"Raduj se z profitu a profituj z radosti"                                             # "Take joy from profit, and profit from joy."
   "57" "Dobří zákazníci jsou vzácní jako latinium - opatruj je"                              # "Good customers are as rare as latinum. Treasure them."
   "58"	"Neexistuje náhražka za úspěch"                                                       # "There is no substitute for success."
   "59"	"Rada zdarma je málokdy levná"                                                        # "Free advice is seldom cheap."
   "60"	"Dbej na to, abys lhal důsledně"                                                      # "Keep your lies consistent."
   "62" "Čím riskantnější cesta, tím větší zisk"                                              # "The riskier the road, the greater the profit."
   "63"	"Práce je nejlepší terapie, přinejmenším pro tvoje zaměstnance"                       # "Work is the best therapy - at least for your employees."
   "65"	"Vyhraj nebo prohraj, vždycky tu je šňupací prášek z huyperianských brouků"           # "Win or lose, there's always Hupyrian beetle snuff"
   "66"	"Vždycky má někdo větší uši než ty"                                                   # "Someone's always got bigger ears."
   "68"	"Risk se vždy nerovná zisk"                                                           # "Risk doesn't always equal reward."
   "69"	"Ferengové nejsou zodpovědní za hloupost ostatních druhů"                             # "Ferengi are not responsible for the stupidity of other races."
   "74" "Znalost rovná se zisk"                                                               # "Knowledge equals profit."
   "75" "Domov je tam, kde je srdce, ale hvězdy jsou z latinia"                               # "Home is where the heart is, but the stars are made of latinum."
   "76"	"Jednou za čas vyhlas mír. Úplně tím zmateš své nepřátele"                            # "Every once in a while, declare peace. It confuses the hell out of your enemies."
   "77"	"Když něco rozbiješ, vlastně jsi to koupil"                                           # "If you break it, I'll charge you for it!"
   "79"	"Dej si pozor na vulkanskou lačnost po znalostech"                                    # "Beware of the Vulcan greed for knowledge."
   "82"	"Čím horší produkt, tím vyšší cena"                                                   # "The flimsier the product, the higher the price."
   "85"	"Nikdy nedovol, aby konkurence věděla, co si myslíš"                                  # "Never let the competition know what you're thinking."
   "87"	"Poznej zákazníkovy slabosti, abys je proti němu dokázal lépe využít"                 # "Learn the customer's weaknesses, so that you can better take advantage of him."
   "88"	"Není po tom, dokud není po tom"                                                      # "It ain't over 'til its over."
   "88"	"Pomsta tě bude stát vše"                                                             # "Vengeance will cost you everything."
   "89"	"Neptej se, co můžeš udělat pro své zisky, ale co ony mohou udělat pro tebe"          # "Ask not what your profits can do for you, but what you can do for your profits."
   "89"	"Je lepší ztratit něco ze zisku a žít, než získat zisk celý a zemřít"                 # "[It is] better to lose some profit and live than lose all profit and die."
   "92"	"Je mnoho cest k zisku"                                                               # "There are many paths to profit."
   "94"	"Ženy a finance nejdou dohromady"                                                     # "Females and finances don't mix."
   "95"	"Expanduj nebo zemři"                                                                 # "Expand or die."
   "96" "Pro každé Pravidlo existuje stejné opačné Pravidlo (kromě případů, kdy neexistuje)"  # "For every Rule, there is an equal and opposite Rule (except when there's not)."
   "97"	"Dost... není nikdy dost"                                                             # "Enough... is never enough."
   "98"	"Každý člověk má svou cenu"                                                           # "Every man has his price."
   "98"	"Pokud to nemůžeš odnést, neodcházej"                                                 # "If you can't take it with you, don't go."
   "99"	"Důvěra je ten největší závazek"                                                      # "Trust is the biggest liability of all."
  "100"	"Řekni pravdu, pokud je dobrá pro obchod"                                             # "When it's good for business, tell the truth."
  "101"	"Zisk triumfuje nad city"                                                             # "Profit trumps emotion."
  "102"	"Příroda zchátrá, ale latinium je věčné"                                              # "Nature decays, but latinum lasts forever."
  "103"	"Spánek se může míchat s příležitostí"                                                # "Sleep can interfere with opportunity."
  "104"	"Víra hory přenáší… hory majetku"                                                     # "Faith moves mountains... of inventory."
  "106"	"V chudobě není cti."                                                                 # "There is no honor in poverty."
  "108"	"Naděje neplatí elektriku"                                                            # "Hope doesn't keep the lights on."
  "108"	"Oblečená žena je jako muž bez zisku"                                                 # "A woman wearing clothes is like a man without any profits."
  "109"	"Důstojnost a prázdný měšec mají cenu toho měšce"                                     # "Dignity and an empty sack is worth the sack."
  "110"	"S vykořisťováním začínáme doma"                                                      # "Exploitation begins at home."
  "111"	"Se svými dlužníky jednej jako s rodinou – vykořisťuj je"                             # "Treat people in your debt like family... exploit them."
  "112"	"Nikdy se nemiluj s šéfovou sestrou"                                                  # "Never have sex with the boss' sister."
  "113"	"Vždycky se miluj se šéfem"                                                           # "Always have sex with the boss."
  "117"	"Nemůžeš osvobodit rybu z vody"                                                       # "You can't free a fish from water."
  "121"	"Všechno je na prodej - i přátelství"                                                 # "Everything is for sale, even friendship."
  "122"	"Nikdy nespi s šéfovou sestrou"                                                       # "Never Sleep with the bosses sister"
  "123"	"I slepec pozná lesk latinia"                                                         # "Even a blind man can recognize the glow of Latinum."
  "125"	"Když jsi mrtvý, nemůžeš obchodovat"                                                  # "You can't make a deal if you're dead."
  "135"	"Poslouchej tajnosti, ale nikdy je neříkej"                                           # "Listen to secrets, but never repeat them."
  "139"	"Manželky slouží, bratři dědí"                                                        # "Wives serve, brothers inherit."
  "141"	"Jenom blázni zaplatí bez smlouvání"                                                  # "Only fools pay retail."
  "142" "Jen blázni provozují velkoobchod"                                                    # "Only fools sell wholesale"
  "144"	"Na charitě není nic špatného… dokud končí v tvé kapse"                               # "There's nothing wrong with charity... as long as it winds up in your pocket."
  "147"	"Lidi milují barmana"                                                                 # "People love the bartender."
  "151"	"I když jsi zákazník - prodej sebe"                                                   # "Even when you're a customer, sell yourself."
  "153"	"Neprodávej steak, ale jeho vůni"                                                     # "Sell the sizzle, not the steak."
  "162"	"I v těch nejhorších časech má někdo zisk"                                            # "Even in the worst of times someone turns a profit."
  "168"	"Prošeptej si cestu k úspěchu"                                                        # "Whisper your way to success."
  "177"	"Znej své nepřátele… ale vždy s nimi obchoduj"                                        # "Know your enemies... but do business with them always."
  "181"	"Ani nepoctivost nepošpiní lesk zisku"                                                # "Not even dishonesty can tarnish the shine of profit."
  "183"	"Když ti život nadělí ungabobule, udělej si čistící prostředek"                       # "When life hands you ungaberries, make detergent."
  "184"	"Fereng počká s nabídkou, až se jeho protivníci vyčerpají"                            # "A Ferengi waits to bid until his opponents have exhausted themselves."
  "188"	"Ani nepoctivost nepošpiní lesk zisku"                                                # "Not even dishonesty can tarnish the shine of profit."
  "189"	"Ať si ostatní udržují svou pověst. Ty se drž jejich peněz"                           # "Let others keep their reputation. You keep their money."
  "190"	"Poslouchej vše, nevěř ničemu"                                                        # "Hear all, trust nothing."
  "192"	"Nikdy nepodváděj Klingona… pokud si nejsi jistý, že ti to projde"                    # "Never cheat a Klingon... unless you're sure you can get away with it."
  "193"	"Problémy přicházejí ve třech"                                                        # "Trouble comes in threes."
  "193"	"Nikdy není pozdě vyhodit zaměstnance"                                                # "It's never too late to fire the staff."
  "194"	"Vždy se vyplatí vědět o nových zákaznících dřív, než vkročí do tvých dveří"          # "It's always good business to know about new customers before they walk in your door."
  "199"	"Umístění, umístění, umístění"                                                        # "Location, location, location."
  "200"	"Fereng si nezvolí jinou stranu, než tu svoji"                                        # "A Ferengi chooses no side but his own."
  "202"	"Ospravedlnění zisku je zisk."                                                        # "The justification for profit is profit."
  "203"	"Noví zákazníci jsou jako ostrozubí červi - mohou být šťavnatí, ale občas koušou"     # "New customers are like razor-toothed gree worms. They can be succulent, but sometimes they bite back."
  "208"	"Někdy to jediné nebezpečnější než otázka je odpověď"                                 # "Sometimes, the only thing more dangerous than a question is an answer."
  "211"	"Zaměstnanci jsou jako příčky na žebříku úspěchu - neváhej po nich šlapat"            # "Employees are the rungs on the ladder of success. Don't hesitate to step on them."
  "212"	"Dobrá lež je uvěřitelnější než pravda"                                               # "A good lie is easier to believe than the truth."
  "214"	"Nikdy nezačínej obchodní jednání s prázdným žaludkem"                                # "Never begin a (business) negotiation on an empty stomach."
  "216"	"Nikdy se nepouštěj do hry s telepatem!"                                              # "Never gamble with a telepath."
  "217"	"Vždycky musíš vědět, co kupuješ (Nekupuj zajíce v pytli.)"                           # "Always know what you're buying."
  "217"	"Nemůžeš vysvobodit rybu z vody"                                                      # "You can't free a fish from water."
  "218"	"Věc zadarmo tě může stát příliš mnoho"                                               # "Sometimes what you get free costs entirely too much."
  "219"	"Vlastnictví je 11/10 práva"                                                          # "Possession is eleven-tenths of the law!"
  "223"	"Pozor na muže, který si neudělá čas na oo-mox"                                       # "Beware the man who doesn't take time for Oo-mox."
  "227"	"Co je napsáno, to je napsáno"                                                        # "If that's what's written, then that's what's written."
  "229"	"Latinium vydrží déle než rozkoš"                                                     # "Latinum lasts longer than lust."
  "235"	"Skrč se, smrt je vysoká"                                                             # "Duck; death is tall."
  "236"	"Nemůžeš si koupit osud"                                                              # "You can't buy fate."
  "239"	"Nikdy se neboj věc přejmenovat"                                                      # "Never be afraid to mislabel a product."
  "240"	"Čas je stejně vzácný jako latínium"                                                  # "Time, like latinum, is a highly limited commodity."
  "242"	"Víc je dobré... všechno je lepší"                                                    # "More is good... all is better."
  "243"	"Vždycky si ponechej zadní vrátka"                                                    # "Always leave yourself an out."
  "245" "Když si nemůžeš koupit nepřítele, připrav se na boj"                                 # "If enemy can't be bought, then prepare for fight"
  "248"	"Definice šílenství je, že neustále zkoušiš to stejné, ale očekáváš jiný výsledek"    # "The definition of insanity is trying the same failed scheme & expecting different results."
  "253" "Syntehol je výběrové mazadlo pro zákazníkovu nacpanou peněženku"                     #  "Synthehol is the lubricant of choice for a customer's stuck purse"
  "255"	"Manželka je luxus… chytrý účetní je nezbytnost"                                      # "A wife is luxury... a smart accountant a neccessity."
  "257"	"Bohatý muž si může dovolit cokoliv kromě svědomí"                                    # "When the messenger comes to appropriate your profits, kill the messenger."
  "261"	"Bohatý člověk získá všechno, kromě svědomí"                                          # "A wealthy man can afford anything except a conscience."
  "263"	"Nikdy nedovol, aby pochybnosti zkalily tvou touhu po latiniu"                        # "Never allow doubt to tarnish your lust for latinum."
  "266"	"Když jsi na pochybách, lži"                                                          # "When in doubt, lie."
  "267"	"Když tomu věříš ty, věří tomu i oni"                                                 # "If you believe it, they believe it."
  "272"	"Před obchodem si vždy zkontroluj zboží"                                              # "Always inspect the merchandise before making a deal."
  "280"	"Když to není pokažené, nespravuj to"                                                 # "If it ain't broke, don't fix it."
  "284"	"Každý je v jádru Fereng"                                                             # "Deep down, everyone's a Ferengi."
  "285"	"Žádný dobrý skutek nezůstane nepotrestán"                                            # "No good deed ever goes unpunished."
  "286"	"Když odejde Morn, je všemu konec"                                                    # "When Morn leaves, it's all over."
  "287"	"Vždy nech pracovat někoho za sebe"                                                   # "Always get somebody else to do the lifting."
  "288"	"Nedostaň se do situace, ze které bys nemohl vyváznout"                               # "Never get into anything that you can't get out of."
  "289"	"Člověk má cenu jeho majetku"                                                         # "A man is only worth the sum of his possessions."
  "290"	"Rozzuřený člověk je nepřítel, spokojený je přítel"                                   # "An angry man is an enemy, and a satisfied man is an ally."
  "291"	"Čím míň zaměstanců ví o zisku, tím ménší podíl můžou žádat"                          # "The less employees know about the cash flow, the smaller the share they can demand."
  "292"	"Jenom blázen odmítne nabídku k obchodu"                                              # "Only a fool passes up a business opportunity."
  "293"	"Čím víc času stráví rozhodováním, tím víc peněz utratí"                              # "The more time they take deciding, the more money they will spend."
  "294"	"Výhodný obchod neexistuje"                                                           # "A bargain usually isn't."
  "299"	"Když někoho využiješ, poděkuj mu - vyplatí se to"                                    # "Whenever you exploit someone, it never hurts to thank them...That way it's easier to exploit them the next time."
  "431"	"Až začne střílení, nechej to na žoldácích"                                           # "When the shooting starts, let the mercenaries handle it!"
  ) 
 
# Spočítáme kolik je pravidel 
COUNT=${#rules[@]}

# Vytvoříme náhodně číslo
random=$((0 + $RANDOM % $COUNT))

# Zkontrolujeme, zda je číslo liché nebo sudé
# Pokud je číslo liché nastavíme je na sudé
if [ $((random%2)) -ne 0 ];
then
    even=$((random+1))
else
    even=$random
fi

# Nadefinujeme proměnné pro výběr hodnot z pole
rule_number=$even
rule_text=$((even+1))

# Vybereme hodnoty z pole
number=${rules[$rule_number]}
rule=${rules[$rule_text]}

# Výsledný text
#   $number - číslo pravidla
#   $rule   - text pravidla 
# 
# Změňte si to jak chcete. Fanatazii se meze nekladou

printf "\n  Ferengská Pravidla Zisku \n"
printf "  ========================\n\n"
printf "    Pravidlo č. $number: $rule\n\n"

