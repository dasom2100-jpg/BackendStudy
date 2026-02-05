window.onload = function () {
	// submit을 위한 form태그 가져오기
    let frm = document.getElementById('frm'); 
    
    //폼태그의 submit시 실행되는 이벤트 등록
    frm.addEventListener('submit', submitValid);

    //유효성체크할 엘리먼트들 모두 가져오기
    let blurEventElements = document.querySelectorAll(".errMsg"); 
    
    //입력요소의 blur시 실행되는 이벤트 등록
    blurEventElements.forEach(function (obj) {
        obj.addEventListener('blur', validFnc);
    });

    //비번 내용 보이기 아이콘
    document.getElementById('viewEye').addEventListener('click', function () {
        if (this.getAttribute('class') === 'close') {
            this.setAttribute('class', 'open');
            this.setAttribute('src', 'img/eyeclose.svg');
            document.getElementById('upw').setAttribute('type', 'text');
        } else {
            this.setAttribute('class', 'close');
            this.setAttribute('src', 'img/eyeopen.svg');
            document.getElementById('upw').setAttribute('type', 'password');
        }
    });
};

// submit시 유효성 확인
function submitValid(e) {

    //반복문 사용하기 위해 HTMLCollection타입을 Array 타입으로 변환
    let chidrenElements = Array.prototype.slice.call(document.getElementById('frm').querySelectorAll(".errMsg"));

    let trueCnt = 0;
    // 해당 자식 엘리먼트 요소 하나하나에 유효성체크 메인 함수 연결
    chidrenElements.forEach(function (obj) {
        if (validFnc(obj, e.target.getAttribute('id'))) trueCnt++;
    });


    let totalElementLenth = document.getElementById('ubirth').value == '' ? chidrenElements.length - 1 : chidrenElements.length;

    if (trueCnt !== totalElementLenth) {
        e.preventDefault();
    } else {
        return true;
    }
}

// 유효성체크 메인함수
function validFnc(targets, id) {
    let thisElement = Boolean(id) ? targets : this;
    let thisElementIdName = thisElement.getAttribute('id');

    let idmatchstr = { 
		uid: '아이디는', 
		upw: '비밀번호는', 
		unm: '이름은', 
		utel: '전화번호는', 
		umail: '이메일은' 
	};

    // 필수입력 요소 체크
    if (
        thisElementIdName === 'uid' || thisElementIdName === 'upw'
        || thisElementIdName === 'unm' || thisElementIdName === 'utel' 
        || thisElementIdName === 'umail') 
    {
    	if ( thisElement.value === null || thisElement.value === undefined || thisElement.value === ''){
        	viewErrorMsg(thisElement, `${idmatchstr[thisElementIdName]} 반드시 입력해주셔야 합니다.<br>`);
        	return false;
    	} else {
        	deleteErrMsg(thisElement.nextElementSibling);
    	}
	}


    // 유효성 체크 결과를 저장하는 변수
    let validResult;
    let regex;
    switch (thisElementIdName) {
        case 'uid':
            validResult = stdValid(thisElementIdName, thisElement, /^[a-zA-Z][\w]{5,19}$/) 
            				&& whiteSpaceValid(thisElement, /[\s]+/);
            break;
        case 'upw':
            validResult = stdValid(thisElementIdName, thisElement, /(\w|\W|0-9){6,20}$/) 
            && whiteSpaceValid(thisElement, /[\s]+/) 
            && specialCharNumberUpperValid(thisElement, [/[A-Z]/g, /[\W\_]/, /[0-9]+/, /[ㅏ-ㅣㄱ-ㅎ가-힣]+/]);
            break;
        case 'unm':
            validResult = stdValid(thisElementIdName, thisElement, /[a-zA-Z\s가-힣]{2,50}$/);
            break;
        case 'utel':
            validResult = stdValid(thisElementIdName, thisElement, /(010)\d{4}\d{4}$/);
            break;
        case 'umail':
			regex = /^[a-zA-Z][a-zA-Z0-9\_\.\-]+[@][a-zA-Z\_\.\-]+[.][a-zA-Z]+[.]*[a-zA-Z]*$/ ;
            validResult = stdValid(thisElementIdName, thisElement, regex);
            break;
        default:
            //생년월일은 입력값이 있는 경우만 유효성 체크
            if (thisElement.value !== "") {
                validResult = dateValid(thisElement, /(\d{4})(\d{2})(\d{2})$/);
            } else {
                deleteErrMsg(thisElement.nextElementSibling);
            }
    }

    // 유효성체크가 통과되지 못하면 false 반환
    if (!validResult) return false;

    return true;
}

// 기존에 띄워진 에러메세지 태그가 존재하면 삭제(새로운 메세지를 띄우기 위해)
function deleteErrMsg(ele) {
    if (ele.tagName == 'P') {
        ele.remove();
    }
}

// 에러메세지 태그 보이기
function viewErrorMsg(thisElement, errMsgStr) {
    deleteErrMsg(thisElement.nextElementSibling);

    let errMsgElement = document.createElement('p');
    errMsgElement.setAttribute('class', thisElement.getAttribute('id'));
    errMsgElement.classList.add('errMsgShow');
    errMsgElement.innerHTML = errMsgStr;
    thisElement.after(errMsgElement);
}

// 유효성체크 서브함수 - 기본 정규식 체크
function stdValid(idname, currentElement, regex) {
    let errMsg = {
        uid: '아이디 첫글자는 영어로 시작해야하며 총 6-20자 이내의 영어, 숫자, _까지만 가능합니다.',
        upw: '비밀번호는 6-20자 이내의 영어, 숫자, 특수문자까지만 가능합니다.',
        unm: '이름은 5-50자 이내의 영어, 한글(단자음, 단모음불가)까지만 가능합니다.',
        utel: '연락처는 숫자로만 형식을 지켜서 입력해주세요. 예) 01012341234',
        umail: '이메일은 형식을 지켜서 입력해주세요. 예) admin@host.com',
    };
    if (!regex.test(currentElement.value)) {
        viewErrorMsg(currentElement, errMsg[idname] + '<br>');
        return false;
    } else {
        deleteErrMsg(currentElement.nextElementSibling);
    }

    return true;
}

// 유효성체크 날짜 체크함수
function dateValid(currentElement, regex) {
    deleteErrMsg(currentElement.nextElementSibling);
    let boolchk = true;
    let currentDate = new Date();
    let inputDate = currentElement.value.match(regex);
    let errMsg = '';
    if (Boolean(Number(currentElement.value))) {
        let year = Number(inputDate[1]);
        let mon = Number(inputDate[2]);
        let date = Number(inputDate[3]);

        if (new Date(year, mon - 1, date).getTime() > currentDate.getTime()) {
            errMsg = `금일 이후의 날짜는 입력이 불가능합니다.`;
            viewErrorMsg(currentElement, errMsg + '<br>');
            return false;
        }

        if (year < 1900 || year > currentDate.getUTCFullYear()) {
            errMsg = `년도는 1900-${currentDate.getUTCFullYear()}년도 사이에서 입력이 가능합니다.`;
            viewErrorMsg(currentElement, errMsg + '<br>');
            return false;
        }
        if (mon < 1 || mon > 12) {
            errMsg = `월은 1-12월 사이에서 입력이 가능합니다.`;
            viewErrorMsg(currentElement, errMsg + '<br>');
            return false;
        }
        if (date == 0) {
            errMsg = `일자는 0일이 올 수 없습니다.`;
            viewErrorMsg(currentElement, errMsg + '<br>');
            return false;
        }
        switch (mon) {
            case 2:
                if (year % 4 === 0) {
                    if (date > 29) {
                        errMsg = `${mon}월은 29일까지만 가능합니다.`;
                        boolchk = false;
                    }
                } else {
                    if (date > 28) {
                        errMsg = `${mon}월은 28일까지만 가능합니다.`;
                        boolchk = false;
                    }
                }
                break;
            case 4: case 6: case 9: case 11:
                if (date > 30) {
                    errMsg = `${mon}월은 31일까지만 가능합니다.`;
                    boolchk = false;
                }
                break;
            default: if (date > 31) {
                errMsg = `${mon}월은 31일까지만 가능합니다.`;
                boolchk = false;
            }
        }
        if (!boolchk) {
            viewErrorMsg(currentElement, errMsg + '<br>');
            return false;
        } else {
            return true;
        }
    } else {
        errMsg = '날짜는 숫자로만 입력해주세요.';
        viewErrorMsg(currentElement, errMsg + '<br>');
        return false;
    }
}

// 유효성체크 서브함수 - 공백 체크
function whiteSpaceValid(currentElement, regex) {
    if (currentElement.value.search(regex) > -1) {
        viewErrorMsg(currentElement, '공백을 사용하실 수 없습니다.' + '<br>');
        return false;
    } else {
        deleteErrMsg(currentElement.nextElementSibling);
    }
    return true;
}

// 유효성체크 서브함수 - 특수문자 , 숫자, 영어대문자, 한글 체크
function specialCharNumberUpperValid(currentElement, regex) {
    if (
        Number(currentElement.value.search(regex[0])) < 0 ||
        Number(currentElement.value.search(regex[1])) < 0 ||
        Number(currentElement.value.search(regex[2])) < 0 ||
        Number(currentElement.value.search(regex[3])) > -1
    ) {
        viewErrorMsg(currentElement, '영어대문자, 숫자, 특수문자는 각각 반드시 1개이상 입력해주어야 합니다.(한글입력 불가)' + '<br>');
        return false;
    } else {
        deleteErrMsg(currentElement.nextElementSibling);
    }
    return true;
}