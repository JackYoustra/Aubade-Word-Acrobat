import javax.swing.JFrame;
import javax.swing.JButton;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JLabel;
import javax.swing.SwingConstants;
import java.awt.Font;
import javax.swing.JPanel;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;


public class MainWindow extends JFrame{
	private JButton btnBegin;
	private JLabel lblAubade;
	private JPanel backgroundPanel;
	
	public MainWindow() {
		getContentPane().setLayout(null);
		
		backgroundPanel = new JPanel();
		backgroundPanel.setBounds(0, 0, 1016, 755);
		getContentPane().add(backgroundPanel);
		backgroundPanel.setLayout(null);
		
		final int halfwidth = backgroundPanel.getWidth()/2;
		final int halfheight = backgroundPanel.getHeight()/2;
		
		btnBegin = new JButton("Begin");
		btnBegin.setBounds(463, 188, 184, 35);
		backgroundPanel.add(btnBegin);
		btnBegin.setFont(new Font("Tahoma", Font.BOLD, 21));
		lblAubade = new JLabel("Aubade");
		lblAubade.setBounds(halfwidth-(91/2), halfheight, 282, 94);
		backgroundPanel.add(lblAubade);
		lblAubade.setFont(new Font("Lucida Calligraphy", Font.PLAIN, 68));
		lblAubade.setHorizontalAlignment(SwingConstants.CENTER);
		
		btnBegin.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				explodeStart();
			}
		});
	}

	private void explodeStart() {
		
	}
}
