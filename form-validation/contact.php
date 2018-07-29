<?php

/*

  This file exists as a reference, but don't use it.
  Use https://github.com/raffaelj/cockpit_FormValidation/ instead.
  It's an addon with cleaner code and more features and it works 
  without the mentioned PR below.
  

  custom form validation for spam protection for cockpit
  
  needs Pull request: https://github.com/agentejo/cockpit/pull/798
  or: https://github.com/raffaelj/cockpit/tree/cp-next_form-validation-response
  to work. The current behavior is to send 404 if false or continue
  
  returns false if invalid and exit marker is set
  returns true if valid
  returns error messages as array
  
  place this file in /cockpit/config/forms/contact.php
  
  call it with https://urltocockpit.de/api/forms/submit/contact?token=qwertz12345
  and send json like : {"form":{"name":"Raffael","message":"blabliblub", "confirm":"1","mail":"+49 1234 56789012"}}
  
  To do:
  
  * [ ] 
  
  
*/

// form validation 

namespace validate_form;

// configuration

$honeypot = [
  "fieldname" => "confirm"
 ,"expected_value" => "0"
 ,"response" => true
];

$required_fields = [
  "name"
 ,"telephone"
 ,"mail"
 ,"message"
];

$field_is = [
  "telephone" => ["phone"]
 ,"mail" => ["email"]
 ,"site_url" => ["url"]
];

$field_is_not = [
  "telephone" => ["email", "url"]
 ,"mail" => ["phone", "url"]
 ,"site_url" => ["email","phone"]
];

// $contains_not = [
  // ...
// ];

$validation_options = [
  "honeypot" => $honeypot
 ,"required" => $required_fields
 ,"field_is" => $field_is
 ,"field_is_not" => $field_is_not
 // ,"contains_not" => "..."
];


class validate_form{

// requires: PECL intl extension (for punycode conversion of urls and mail adresses)
  
  public $error = false;
  private $options = [];
  private $data = [];
  private $exit = false;
  
  function __construct($data, $options){
    
    $this->options = $options;
    $this->data = $data;
    
    $this->validate();
    
  }
  
  function validate(){
    
    foreach( $this->options as $key=>$val ){
      if( method_exists($this, $key) )
          $this->$key($val);
      else
        $this->error["method"][$key] = "does not exist";
    }
    
  }
  
  function response(){
    
    if($this->exit)
      return false;
    
    if($this->error)
      return $this->error;
    
    return true;
  }
  
  function honeypot($opt){
    
    if( $this->data[$opt["fieldname"]] && $this->data[$opt["fieldname"]] != $opt["expected_value"] ){
      $this->error["honeypot"] = "Hello spambot";
      
      // optional: send 404 to spambots
      if(!$opt["response"])
        $this->exit = true;
    }
    
  }
  
  function required($opt){
    
    foreach($opt as $val){
      if( !isset($this->data[$val]) or empty($this->data[$val]) )
        $this->error[$val][] = "is required";
    }
    
  }
  
  function field_is($opt, $inverse = false){
    
    foreach($opt as $field => $methods){
      
      foreach($methods as $method){
        
        $m = "is_$method";
        
        if( method_exists($this, $m) ){
          
          if( !empty($this->data[$field]) ){
            
            $res = $this->$m($field);
          
            // $this->error["res"][] = $res; // --> for debugging
            
            if(!$res && !$inverse)
              $this->error[$field][] = "must be of type $method";
            if($res && $inverse)
              $this->error[$field][] = "must not be of type $method";
            
          }
        
        }
        else
          $this->error["method"][$m] = "does not exist";
      
      }

    }
    
  }
  
  function field_is_not($opt){
    
    $this->field_is($opt, true);
    
  }
  
  function is_phone($field){
    
    // allow sloppy input with +,-,(),whitspace but no chars
    return !preg_match('~[^-\s\d./()+]~', $this->data[$field]);
    
  }
  
  function is_email($field){
    
    return filter_var(idn_to_ascii($this->data[$field]), FILTER_VALIDATE_EMAIL);
    
  }
  
  function is_url($field){
    
    return filter_var(idn_to_ascii($this->data[$field]), FILTER_VALIDATE_URL);
    
  }
  
  // some more possible validations...

  // check if input contains code
  
  // check if input contains url(s)
  
  // bool, number, ascii, ...
  
}

$validation = new validate_form($data, $validation_options);
return $validation->response();