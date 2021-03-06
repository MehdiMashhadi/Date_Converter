#!/usr/bin/perl


while(1){
	print "----------------------------------\n\nif gregorian_to_jalali -> press: g\nor jalali_to_gregorian -> press: j\nand finish -> 	press: Ctrl+C\n";
	chomp($tabdil = <STDIN>);
	print "enter day: ";
	chomp($day_in=<STDIN>);
	print "enter month: ";
	chomp($month_in=<STDIN>);
	print "enter year: ";
	chomp($year_in=<STDIN>);
	
	if($tabdil eq "g"){
		print "----------------------------------\ngregorian: ".$year_in."-".$month_in."-".$day_in."\n";
		@tarikh_out=gregorian_to_jalali($year_in,$month_in,$day_in);
		print "jalali: ".$tarikh_out[0]."/".$tarikh_out[1]."/".$tarikh_out[2]."\n";
	}else{
		print "----------------------------------\n"."jalali: ".$year_in."/".$month_in."/".$day_in."\n";
		@tarikh_out=jalali_to_gregorian($year_in,$month_in,$day_in);
		print "gregorian: ".$tarikh_out[0]."-".$tarikh_out[1]."-".$tarikh_out[2]."\n";
	}
}






sub gregorian_to_jalali{ #($gy,$gm,$gd)
 my($gy,$gm,$gd)=@_;
 # $gy=$_[0];
 # $gm=$_[1];
 # $gd=$_[2];
 @g_d_m=(0,31,59,90,120,151,181,212,243,273,304,334);
 if($gy>1600){
  $jy=979;
  $gy-=1600;
 }else{
  $jy=0;
  $gy-=621;
 }
 $gy2=($gm>2)?($gy+1):$gy;
 $days=(365*$gy) +(int(($gy2+3)/4)) -(int(($gy2+99)/100)) +(int(($gy2+399)/400)) -80 +$gd +$g_d_m[$gm-1];
 $jy+=33*(int($days/12053)); 
 $days%=12053;
 $jy+=4*(int($days/1461));
 $days%=1461;
 if($days > 365){
  $jy+=int(($days-1)/365);
  $days=($days-1)%365;
 }
 $jm=($days < 186)?1+int($days/31):7+int(($days-186)/30);
 $jd=1+(($days < 186)?($days%31):(($days-186)%30));
 return ($jy,$jm,$jd);
}


sub jalali_to_gregorian{ #($jy,$jm,$jd)
 my($jy,$jm,$jd)=@_;
 #$jy=$_[0];
 #$jm=$_[1];
 #$jd=$_[2];
 if($jy>979){
  $gy=1600;
  $jy-=979;
 }else{
  $gy=621;
 }
 $days=(365*$jy) +((int($jy/33))*8) +(int((($jy%33)+3)/4)) +78 +$jd +(($jm<7)?($jm-1)*31:(($jm-7)*30)+186);
 $gy+=400*(int($days/146097));
 $days%=146097;
 if($days > 36524){
  $gy+=100*(int(--$days/36524));
  $days%=36524;
  if($days >= 365){$days++;}
 }
 $gy+=4*(int($days/1461));
 $days%=1461;
 if($days > 365){
  $gy+=int(($days-1)/365);
  $days=($days-1)%365;
 }
 $gd=$days+1;
 $gm=0;
 foreach $v (0,31,(($gy%4==0 and $gy%100!=0) or ($gy%400==0))?29:28 ,31,30,31,30,31,31,30,31,30,31){
  if($gd<=$v){last;}
  $gm++;
  $gd-=$v;
 }
 return ($gy,$gm,$gd); 
}



