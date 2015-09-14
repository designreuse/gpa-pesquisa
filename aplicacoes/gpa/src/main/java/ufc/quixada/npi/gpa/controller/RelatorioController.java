package ufc.quixada.npi.gpa.controller;

import static ufc.quixada.npi.gpa.utils.Constants.PAGINA_RELATORIOS;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ufc.quixada.npi.gpa.model.Pessoa;
import ufc.quixada.npi.gpa.model.Relatorio;
import ufc.quixada.npi.gpa.service.PessoaService;
import ufc.quixada.npi.gpa.service.ProjetoPorDocenteRelatorioService;
import ufc.quixada.npi.gpa.service.ProjetoService;
import ufc.quixada.npi.gpa.utils.Constants;

@Controller
@RequestMapping("direcao/relatorio")
public class RelatorioController {
	
	@Inject
	private ProjetoPorDocenteRelatorioService projetoPorDocenteRelatorioService;
	
	@Inject
	private ProjetoService projetoService;
	
	@Inject
	private PessoaService pessoaService;
	
	@RequestMapping(value = "/aprovados", method = RequestMethod.GET)
	public String aprovados(ModelMap model, @RequestParam(value = "iniInterInicio", required = false) String iniInterInicio,
			@RequestParam(value = "fimInterInicio", required = false) String fimInterInicio,
			@RequestParam(value = "iniInterTermino", required = false) String iniInterTermino,
			@RequestParam(value = "iniInterTermino", required = false) String fimInterTermino) throws JRException {
		
		JRDataSource jrDatasource = new JRBeanCollectionDataSource(projetoService.getProjetosAprovados());

		model.addAttribute("datasource", jrDatasource);
		model.addAttribute("format", "html");
		
		return "projetosAprovados";
	}
	
	@RequestMapping(value = "/reprovados", method = RequestMethod.GET)
	public String reprovados(ModelMap model, @RequestParam(value = "iniInter", required = false) String iniInter, 
			@RequestParam(value = "fimInter", required = false) String fimInter) throws JRException{
		
		//**//
		
		return "projetosReprovados";
		
	}
	
	@RequestMapping(value = "/projeto-por-docente", method = RequestMethod.GET)
	public String projetosDocente(ModelMap model, @RequestParam(value = "idParticipantes", required = true) Long idParticipantes,
			@RequestParam(value="ano", required = false)String ano) throws JRException{
		Relatorio relatorio;
		Integer ano2 = 0;
		if(!ano.isEmpty()){
			ano = ano.substring(1,5);
			ano2 = Integer.parseInt(ano);
		}	
		relatorio = projetoPorDocenteRelatorioService.getRelatorio(idParticipantes, ano2);
		model.addAttribute("NOME_DOCENTE", relatorio.getNomeDoDocente());
		model.addAttribute("ANO_CONSULTA", ano2);
		model.addAttribute("HORAS_TOTAIS",  relatorio.getCargaHorariaTotal());
		model.addAttribute("VALOR_BOLSAS_TOTAL", relatorio.getValorTotalDaBolsa());
		JRDataSource jrDatasource = new JRBeanCollectionDataSource(relatorio.getProjetos());
		model.addAttribute("datasource", jrDatasource);
		model.addAttribute("format", "pdf");
		
		return "relatorioProjetoPorDocente";
	}
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String visualizarRelatorios(Model model, HttpSession session) {
		model.addAttribute("participantes", pessoaService.getParticipantes(getUsuarioLogado(session)));
		
		return PAGINA_RELATORIOS;
	}
	
	private Pessoa getUsuarioLogado(HttpSession session) {
		if (session.getAttribute(Constants.USUARIO_LOGADO) == null) {
			Pessoa usuario = pessoaService
					.getPessoaByCpf(SecurityContextHolder.getContext()
							.getAuthentication().getName());
			session.setAttribute(Constants.USUARIO_LOGADO, usuario);
		}
		return (Pessoa) session.getAttribute(Constants.USUARIO_LOGADO);
	}

}