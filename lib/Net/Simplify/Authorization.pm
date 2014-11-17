package Net::Simplify::Authorization;

=head1 NAME

Net::Simplify::Authorization - A Simplify Commerce Authorization object

=head1 SYNOPSIS

  use Net::Simplify;


  $Net::Simplify::public_key = 'YOUR PUBLIC KEY';
  $Net::Simplify::private_key = 'YOUR PRIVATE KEY';

  # Create a new Authorization.
  my $authorization = Net::Simplify::Authorization->create{ {...});

  # Retrieve a Authorization given its ID.
  my $authorization = Net::Simplify::Authorization->find('a7e41');

  # Delete
  my $authorization = Net::Simplify::Authorization->find('a7e41');
  $authorization->delete();

  # Retrieve a list of objects
  my $authorizations = Net::Simplify::Authorization->list({max => 10});
  foreach my $v ($authorizations->list) {
      # ...
  }

=head1 DESCRIPTION

=head2 METHODS

=head3 create(%params, $auth)

Creates a C<Net::Simplify::Authorization> object.  The parameters are:

=over 4

=item C<%params>

Hash map containing initial values for the object.  Valid keys are:

=over 4

=item amount

Amount of the payment (in the smallest unit of your currency). Example: 100 = $1.00USD [min value: 50, max value: 9999900] (B<required>) 



=item card.addressCity

City of the cardholder. [max length: 50, min length: 2] 

=item card.addressCountry

Country code (ISO-3166-1-alpha-2 code) of residence of the cardholder. [max length: 2, min length: 2] 

=item card.addressLine1

Address of the cardholder. [max length: 255] 

=item card.addressLine2

Address of the cardholder if needed. [max length: 255] 

=item card.addressState

State code (USPS code) of residence of the cardholder. [max length: 2, min length: 2] 

=item card.addressZip

Postal code of the cardholder. The postal code size is between 5 and 9 characters in length and only contains numbers or letters. [max length: 9, min length: 3] 

=item card.cvc

CVC security code of the card. This is the code on the back of the card. Example: 123 

=item card.expMonth

Expiration month of the card. Format is MM. Example: January = 01 [min value: 1, max value: 12] (B<required>) 

=item card.expYear

Expiration year of the card. Format is YY. Example: 2013 = 13 [max value: 99] (B<required>) 

=item card.name

Name as it appears on the card. [max length: 50, min length: 2] 

=item card.number

Card number as it appears on the card. [max length: 19, min length: 13] (B<required>) 

=item currency

Currency code (ISO-4217) for the transaction. Must match the currency associated with your account. [default: USD] (B<required>) 

=item customer

ID of customer. If specified, card on file of customer will be used. 

=item description

Free form text field to be used as a description of the payment. This field is echoed back with the payment on any find or list operations. [max length: 1024] 

=item reference

Custom reference field to be used with outside systems. 

=item replayId

An identifier that can be sent to uniquely identify a payment request to facilitate retries due to I/O related issues. This identifier must be unique for your account (sandbox or live) across all of your payments. If supplied, we will check for a payment on your account that matches this identifier, and if one is found we will attempt to return an identical response of the original request. [max length: 50, min length: 1] 

=item token

If specified, card associated with card token will be used. [max length: 255] 


=back

=item C<$auth>

Authentication object for accessing the API.  If no value is passed the global keys
C<$Net::Simplify::public_key> and C<$Net::Simplify::private_key> are used.

=back




=head3 delete()

Deletes the C<Net::Simplify::Authorization> object.  Authentication is done using the same credentials used when the AccessToken was created.



=head3 list(%criteria, $auth)

Retrieve a list of C<Net::Simplify::Authorization> objects.  The parameters are:

=over 4

=item C<%criteria>

Hash map representing the criteria to limit the results of the list operation.  Valid keys are:

=over 4

=item C<filter>

Filters to apply to the list.



=item C<max>

Allows up to a max of 50 list items to return. [max value: 50, default: 20]



=item C<offset>

Used in pagination of the list. This is the start offset of the page. [default: 0]



=item C<sorting>

Allows for ascending or descending sorting of the list.
The value maps properties to the sort direction (either C<asc> for ascending or C<desc> for descending).  Sortable properties are:

=over 4

=item C<dateCreated>

=item C<amount>

=item C<id>

=item C<description>

=item C<paymentDate>


=back




=back

=back



=head3 find($id, $auth)

Retrieve a C<Net::Simplify::Authorization> object from the API.  Parameters are:

=over 4

=item C<$id>

Identifier of the object to retrieve.

=item C<$auth>

Authentication object for accessing the API.  If no value is passed the global keys
C<$Net::Simplify::public_key> and C<$Net::Simplify::private_key> are used.

=back





=head1 SEE ALSO

L<Net::Simplify>,
L<Net::Simplify::Domain>,
L<Net::Simplify::DomainList>,
L<Net::Simplify::Authentication>,
L<Net::Simplify::ApiException>,
L<http://www.simplify.com>

=head1 VERSION

1.1.0

=head1 LICENSE

Copyright (c) 2013, 2014 MasterCard International Incorporated
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are 
permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of 
conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of 
conditions and the following disclaimer in the documentation and/or other materials 
provided with the distribution.
Neither the name of the MasterCard International Incorporated nor the names of its 
contributors may be used to endorse or promote products derived from this software 
without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF 
SUCH DAMAGE.

=head1 SEE ALSO

=cut

use 5.006;
use strict;
use warnings FATAL => 'all';

use Net::Simplify::Domain;
use Net::Simplify::DomainList;

our @ISA = qw(Net::Simplify::Domain);

sub create {

    my ($class, $params, $auth) = @_;
    
    $auth = Net::Simplify::SimplifyApi->get_authentication($auth);
    my $result = Net::Simplify::SimplifyApi->send_api_request("authorization", 'create', $params, $auth);

    $class->SUPER::new($result, $auth);
}

sub delete {

    my ($self) = @_;

    my $auth = Net::Simplify::SimplifyApi->get_authentication($self->{_authentication});

    my $id = $self->{id};
    $self->merge(Net::Simplify::SimplifyApi->send_api_request("authorization", 'delete', {id => $id}, $auth));
}

sub list {
    my ($class, $criteria, $auth) = @_;
   
    $auth = Net::Simplify::SimplifyApi->get_authentication($auth);
    my $result = Net::Simplify::SimplifyApi->send_api_request("authorization", 'list', $criteria, $auth);

    Net::Simplify::DomainList->new($result, $class, $auth);
}

sub find {
    my ($class, $id, $auth) = @_;

    $auth = Net::Simplify::SimplifyApi->get_authentication($auth);
    my $result = Net::Simplify::SimplifyApi->send_api_request("authorization", 'find', { id => $id }, $auth);

    $class->SUPER::new($result, $auth);
}


1;
