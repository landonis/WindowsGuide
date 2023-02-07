#echo yes if "abc" contains "a"
echo yes | ?{"abc".contains("a")} 
#                                 →yes

#echo no if not "abc" contains "A"
echo no | ?{!"abc".contains("A")}
#                                 →no

#if variable contains variable
$a = "Testing String"
echo yes | ?{$a.contains($a)}
#                                 →yes
