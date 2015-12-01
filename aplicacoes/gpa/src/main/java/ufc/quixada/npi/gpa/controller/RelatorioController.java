package ufc.quixada.npi.gpa.controller;

import static ufc.quixada.npi.gpa.utils.Constants.PAGINA_RELATORIOS;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ufc.quixada.npi.gpa.model.Pessoa;
import ufc.quixada.npi.gpa.service.PessoaService;
import ufc.quixada.npi.gpa.service.RelatorioService;

@Controller
@RequestMapping("direcao/relatorios")
public class RelatorioController {
	
	@Inject
	private RelatorioService relatorioService;
	
	@Inject
	private PessoaService pessoaService;
	
	@RequestMapping(value = "/aprovados", method = RequestMethod.GET)
	public String Aprovados(ModelMap model, @RequestParam(value = "inicio", required = false) String inicio, 
			@RequestParam(value = "termino", required = false) String termino, HttpSession session) {
		model.addAttribute("relatorio", relatorioService.getProjetosAprovadosRelatorio(inicio, termino));
		return PAGINA_RELATORIOS;
	}

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String visualizarRelatorios(Model model, HttpSession session, Authentication authentication) {
		Pessoa pessoa = pessoaService.getPessoa(authentication.getName());
		model.addAttribute("participantes", pessoaService.getParticipantes(pessoa));
		model.addAttribute("pessoas", pessoaService.getAll());
		return PAGINA_RELATORIOS;
	}
	
	@RequestMapping(value = "/reprovados", method = RequestMethod.GET)
	public String Reprovados(ModelMap model, @RequestParam(value = "submissao", required = false) String submissao, HttpSession session){
		model.addAttribute("relatorio", relatorioService.getProjetosReprovadosRelatorio(submissao));
		return PAGINA_RELATORIOS;
	}
	
	@RequestMapping(value = "/p-pessoa", method = RequestMethod.GET)
	public String PorPessoa(ModelMap model, @RequestParam(value = "id", required = true) Long id,@RequestParam(value = "ano", required = false) String ano, HttpSession session){
		model.addAttribute("relatorio", relatorioService.getProjetosPorPessoa(id, ano));
		return PAGINA_RELATORIOS;
	}
	
}
