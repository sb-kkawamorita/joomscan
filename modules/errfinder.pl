#start Checking common logs
dprint("Finding common log files name");
$ertf=0;
@error = ('error.log','error_log','php-scripts.log','php.errors','php5-fpm.log','php_errors.log','debug.log','security.txt','.well-known/security.txt');
foreach $er(@error){

    $response=$ua->get("$target/$er");
    my $headers  = $response->headers();
    my $content_type =$headers->content_type();
    if ($response->status_line =~ /200/g ){
        if($content_type !~ m/text\/html/i){
            tprint("$er path :  $target/$er\n");
           $ertf=1;
        }
    }
}
if($ertf==0) {
    fprint("error log is not found");
}
#end Checking common logs