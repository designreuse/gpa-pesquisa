package ufc.quixada.npi.gpa.service.validation;

import javax.inject.Named;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import ufc.quixada.npi.gpa.model.ParecerRelator;

@Named
public class ParecerRelatorValidador implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return ParecerRelator.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmpty(errors, "relator", "projeto.campoNulo");
	}
}
