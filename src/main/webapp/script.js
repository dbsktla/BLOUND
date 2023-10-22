var use;
var isCheck = false;

function writeSave(){ //가입 클릭시 유효성 검사
	if($('input[name=id]').val() == ""){
		alert("아이디를 입력해 주세요.");
		$('input[name=id]').focus();
		return false;
	}
	if(use == "missing"){
		alert("아이디를 입력해 주세요.")
		$("input[name=id]").focus();
		return false;
	}
	else if(use == "impossible"){
		alert("이미 등록된 아이디입니다.")
		$("input[name=id]").select();
		return false;
	}
	else if(isCheck == false){
		alert("ID 중복체크를 해야합니다.")
		return false;
	}
	if($('input[name=password]').val() == ""){
		alert("비밀번호를 입력해 주세요.");
		$('input[name=password]').focus();
		return false;
	}
	if(pwuse == "pwerror"){
		alert("비밀번호 형식이 잘못 됐습니다.");
		return false;
	}
	if(pwsame == "nosame"){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	if($('input[name=password2]').val() == ""){
		alert("비밀번호 확인을 입력해 주세요.");
		$('input[name=password2]').focus();
		return false;
	}
	if($('input[name=name]').val() == ""){
		alert("이름을 입력해 주세요.");
		$('input[name=name]').focus();
		return false;
	}
	if($('input[name=postcode]').val() == ""){
		alert("주소를 입력해 주세요.");
		$('input[name=postcode]').focus();
		return false;
	}
	if($('input[name=email]').val() == ""){
		alert("이메일을 입력해 주세요.");
		$('input[name=email]').focus();
		return false;
	}
	if($('input[name=rrn1]').val() == ""){
		alert("주민등록번호를 입력해 주세요.");
		$('input[name=rrn1]').focus();
		return false;
	}
	if($('input[name=rrn2]').val() == ""){
		alert("주민등록번호를 입력해 주세요.");
		$('input[name=rrn2]').focus();
		return false;
	}
	if($('input[name=hp2]').val() == ""){
		alert("휴대 전화 번호를 입력해 주세요.");
		$('input[name=hp2]').focus();
		return false;
	}
	if($('input[name=hp3]').val() == ""){
		alert("휴대 전화 번호를 입력해 주세요.");
		$('input[name=hp3]').focus();
		return false;
	}
}//writeSave

function duplicate(){
	isCheck = true;
	$.ajax({
		url : "id_check_proc.jsp",
		data : ({
			userid : $("input[name=id]").val()
		}),
		success : function(data) {
			if($('input[name=id]').val()==""){
				$("#idmessage").html('<font color=red>아이디를 입력하세요<font>').show();
				$('input[name=id]').focus();
				use = "missing";
			}
			else if($.trim(data) == "NO"){
				$("#idmessage").html('<font color=red>이미 등록된 아이디입니다<font>').show();
				$('input[name=id]').select();
				use = "impossible";
			}
			else if($.trim(data) == "YES"){
				$("#idmessage").html('<font color=blue>사용 가능한 아이디입니다<font>').show();
				use = "possible";
			}
		}
	});//ajax
}//duplicate

function keyd(){
	$('#idmessage').css('display','none');
	use = "";
	isCheck = false;
}//keyd

function pwcheck(){
	//영문 소문자/숫자 조합 3~8자
	pw = $('input[name=password]').val();
	
	//영문 소문자/숫자 3~8인가 알아보기 / i=대소문자 무시
	var regexp = /^[a-z0-9]{3,8}$/i;
	//if(pw.search(regexp) == -1){ //못 찾으면 -1
	if(!regexp.test(pw)){ //패턴에 맞으면 true 틀리면 false
		alert("비밀번호 형식이 올바르지 않습니다.");
		pwuse = "pwerror";
		return;
	}
	
	//조합 됐나 알아보기
	//알파벳의 위치와 숫자의 위치 찾아보기 / 못 찾으면 -1, 즉 숫자나 문자중 하나가 없다는거
	var chk_num = pw.search(/[0-9]/);
	var chk_eng = pw.search(/[a-z]/i);
	if(chk_num < 0 || chk_eng < 0){ //둘중에 하나라도 없다면
		alert("비밀번호는 영문자와 숫자의 조합으로 작성하세요.");
		pwuse = "pwerror";
	}else{
		pwuse = "";
	}
}//pwcheck

function pw2check(){
	if($('input[name=password]').val() == $('input[name=password2]').val()){
		$('#pwmessage').html("<font color=blue>비밀번호 일치</font>");
		pwsame = "same";
	}else{
		$('#pwmessage').html("<font color=red>비밀번호 불일치</font>");
		pwsame = "nosame";
	}
}//pw2check




