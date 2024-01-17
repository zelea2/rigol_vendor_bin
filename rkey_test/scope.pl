#!/usr/bin/perl

$keep =
    "(CApiLicense::verifyLicense|CApiLicense::getLicenseKey|CApiLicense::verifyOption|API_SetStr2Hex|RString::toUpper|sub_A1036C|RString::split|RString::remove|RString::trimmed|CApiLicense::generate_something|RFile::RFile)";
		
$lnr      = 0;
$out      = 0;
%lfn		  = ();
%fn       = ( # needed functions but excluded for now from the asm
  "sub_25874C" => "// join strings",
  "sub_A0FD34" => "",
  "sub_A0FE5C" => "",
  "sub_A0FF1C" => "",
  "sub_A0EA08" => "",
  "nullsub_6"  => "",
);

%libc = (
  "abort" => 1, 
  "access" => 1, 
  "close" => 1, 
  "free" => 1, 
  "fstat" => 1, 
  "fsync" => 1, 
  "islower" => 1, 
  "malloc" => 1, 
  "memchr" => 1, 
  "memcmp" => 1, 
  "memcpy" => 1, 
  "memmove" => 1, 
  "memset" => 1, 
  "open" => 1, 
  "remove" => 1, 
  "strcpy" => 1, 
  "strlen" => 1, 
  "strtok" => 1, 
  "toupper" => 1, 
  "usleep" => 1, 
);

%libchk = (
	"__open_2" => 1,
	"__read_chk" => 1,
	"__write_chk" => 1,
	"__umask_chk" => 1,
	"__strchr_chk" => 1,
	"__strrchr_chk" => 1,
);

$lib_file = $ENV{"HOME"} . "/.wine/drive_c/IDA_Pro_8.3/libscope-auklet.so.asm";

open( OFILE, "> libscope.asm" ) || die "create libscope.asm - $!\n";
print( OFILE "\t.text\n\n" );

open( HFILE, "$lib_file" ) || die "open $lib_file - $!\n";

while( $ln = <HFILE> )
{
  $lnr++;
  $l = $lnr     if( $ln =~ /^@\s+Attributes/ );
  next          if( !$out && $ln !~ /$keep/ );
  $out = 1      if( $lnr == $l + 2 );
  append_line() if( $out );
	if( index( $ln, "End of function" ) >= 0 )
	{
		print( OFILE "\n\n" );
    $out = 0;
	}
}
close( HFILE );

foreach $f ( sort ( keys %fn ) )
{
	next if( defined $lfn{$f} || defined $libc{$f} || defined $libchk{$f} );
  print( OFILE "$f: $fn{$f}\n\tRET\n\n" );
}

%ascii = (
  "aRigolScope"    => "[RIGOL.SCOPE]",
  "aSSDGenNewKey"  => "[%s][%s][%d]:Gen NEW KEY",
  "aGetlicensekey" => "getLicenseKey",
  "aRkeyData"      => "RKey.data",
  "aSrcCppScopeApi_6" => "src/cpp/scope/api/license",
  "asc_A2C12F"     => ";",
  "asc_A25ADA"     => "#",
);
print( OFILE "\t.data\n\n" );
foreach $a ( keys %ascii )
{
  print( OFILE "$a: .ascii \"$ascii{$a}\"\n\t.byte 0\n" );
}
print( OFILE "bytezr: .byte 0\n\n" );
close( OFILE );

exit;

sub append_line
{
  $ln =~ s/[\s\r\n]+$//;
  $ln =~ s+@+//+g;
  $ln =~ s+â.*++;
	$lfn{$1} = 1 if( $ln =~ /^(\w+):/ );
  $fn{$2} = $3, $ln = "$`$1\t$2$3" if( $ln =~ /(BL?)\s+\.(\w+)(\s+\/\/\s+.*)?/ );
  $ln =~ s+#:pg_hi21:+:pg_hi21:+;
  if( $ln =~ /,#\(qword_([0-9A-F]+) - (0x[0-9A-F]+)\)\]/ )
  {
    my $delta = hex( "0x$1" ) - hex( $2 );
    $ln = "$`,#$delta]";
  }
  $ln =~ s/(ADRP\s+\w+,\s*#0x)/\/\/ $1/;
  $ln =~ s/\[SP\+var_s0\]/[SP]/;
  $ln =~ s/\[SP\+[^\]]+\]/[SP]/
      if( $ln =~ /\[SP\+0x(\w+)\+var_(\w+)\]/ && $1 eq $2 );
  if( $ln =~ /ADRL\s+(\w+),\s*(.+)/ )
  {
    print( OFILE "\t\tADRP\t$1, :pg_hi21:$2\n\t\tADD\t$1, $1, #:lo12:$2\n" );
    return;
  }
  print( OFILE "$ln\n" );
}
# end
