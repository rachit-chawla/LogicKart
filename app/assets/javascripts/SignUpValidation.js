$().ready(function() {
// validate signup form on keyup and submit
		$("#USER_SIGN_UP").validate({
			rules: {
				UserFirstName: "required",
				UserLastName: "required",
				
				UserPassword: {
					required: true,
					minlength: 5
				}
				UserConfirmPassword: {
					required: true,
					minlength: 5,
					equalTo: "#UserPassword"
				},
				UserGender: "required"
				UserAddress: "required"
				UserEmail: {
					required: true,
					email: true
				},
				
			},
			messages: {
				UserFirstName: "Please enter your firstname",
				UserLastName: "Please enter your lastname",
				UserPassword: {
					required: "Please provide a password",
					minlength: "Your password must be at least 5 characters long"
				},
				UserConfirmPassword: {
					required: "Please provide a password",
					minlength: "Your password must be at least 5 characters long",
					equalTo: "Please enter the same password as above"
				},
				UserEmail: "Please enter a valid email address",
				UserGender: "Please select your gender",
				UserAddress: "Please enter your address",
				
			}
		});

	});