#!/usr/bin/perl

use LWP::UserAgent;

use HTTP::Request::Common qw(GET);

use WWW::Mechanize;  

use Socket;

$mech = WWW::Mechanize->new(autocheck => 0);
$ag = LWP::UserAgent->new();

$ag->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");

$ag->timeout(10);

sub getSites {
	for($count=10;$count<=1000;$count+=10)
	{
		$k++;
#		$url = "http://www.hotbot.com/search/web?pn=$k&q=ip%3A$ip&keyvol=01f9093871a6d24c0d94";
		$url = "https://www.bing.com/search?q=ip%3a$ip&go=Submit+Query&qs=ds&first=$count&FORM=PERE$k";
#		$url = "https://www.bing.com/search?q=ip%3A$ip+&count=50&first=$count";
		$resp = $ag->request(HTTP::Request->new(GET => $url));

		$rrs = $resp->content;



		while($rrs =~ m/<a href=\"?http:\/\/(.*?)\//g)
		{
	
			$link = $1;
		
			if ( $link !~ /overture|msn|live|bing|yahoo|duckduckgo|google|yahoo|microsof/)
			{
				if ($link !~ /^http:/)
				{
					$link = 'http://' . "$link" . '/';
				}
	
				if($link !~ /\"|\?|\=|index\.php/)
				{
					if  (!  grep (/$link/,@result))
					{
						push(@result,$link);
					}
				}
			} 
		}
	}
	$found = $#result + 1;
	print "found $found sites\n";
	
}
sub IP_id {
	print "Enter The Ip of Server or Site Link\n";
	print ">> ";
	$input =<stdin>;
	chomp($input);
	if ($input =~ m/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)
	{
		$ip = $input;
		print "Pleast wait ... Getting WebSites...\n";
		getSites();
	}
	elsif ($input =~ m/\D/g)
	{
		if ($input =~ m/https:\/\//)
		{
			$source = substr($input,8,length($input));
			print "Site : $source\n";
			print "Getting IP Adress...\n";
                        $ip = inet_ntoa(inet_aton($source));
                        print "IP: $ip\n";
			print "Pleast wait ... Getting WebSites...\n";
			getSites();
		}
                elsif ($input =~ m/http:\/\//)
                {
                        $source = substr($input,7,length($input));
                        print "Site : $source\n";
			print "Getting IP Adress...\n";
                        $ip = inet_ntoa(inet_aton($source));
                        print "IP: $ip\n";
			print "Pleast wait ... Getting WebSites ...\n";
			getSites();

                }
		else 
		{
			print "Site : $input\n";
			print "Getting IP Adress...\n";
			$ip = inet_ntoa(inet_aton($input));
			print "IP : $ip\n";
			print "Pleast wait ... Getting WebSites...\n";
			getSites();
		}
	}	
}
system(($^O eq 'MSWin32') ? 'cls' : 'clear');
sub Into {
	print qq(
 _______  ___   _______  _______                                                   
|       ||   | |       ||       |            ##############################                                      
|  _____||   | |_     _||    ___|            # Tools By : DR.IMAN         #                            
| |_____ |   |   |   |  |   |___             # Tel : DarkCod3r            #                        
|_____  ||   |   |   |  |    ___|            # Site : Guardiran.org       #                              
 _____| ||   |   |   |  |   |___             # Usage : Perl ext.pl        #                             
|_______||___|   |___|  |_______|            ##############################                                      
 _______  __   __  _______  ______    _______  _______  _______  _______  ______   
|       ||  |_|  ||       ||    _ |  |   _   ||       ||       ||       ||    _ |  
|    ___||       ||_     _||   | ||  |  |_|  ||       ||_     _||   _   ||   | ||  
|   |___ |       |  |   |  |   |_||_ |       ||       |  |   |  |  | |  ||   |_||_ 
|    ___| |     |   |   |  |    __  ||       ||      _|  |   |  |  |_|  ||    __  |
|   |___ |   _   |  |   |  |   |  | ||   _   ||     |_   |   |  |       ||   |  | |
|_______||__| |__|  |___|  |___|  |_||__| |__||_______|  |___|  |_______||___|  |_|

);


	print "\t\t\t    # Enter All For Get All WebSites : ";
	$choice1 = <stdin>;
	chomp ($choice1);
	if ($choice1 eq "all" or $choice1 eq "ALL" or $choice1 eq "4")
	{
		print "\nExtract Server sites\n";
		print "========================\n";
		IP_id();
		map {$_ = "$_\n"} (@result);
		print @result;
		print "Do you want to save the result (Y or N): ";
		$save = <stdin>;
		chomp($save);
		if ($save eq "Y" or $save eq "" or $save eq "y")
		{
			open(sites, ">Result.txt");
			print sites @result;
			print "\t>> Saved at Result.txt\n";
		}

	}
}
Into();
