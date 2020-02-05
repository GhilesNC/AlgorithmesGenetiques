function [vid,PopulAnim,Tio] = Film_ga_init(Population)
close
CM = [76 81 71;242 70 67;255 219 76;19 118 160;238 238 238];
fig = figure('Name','Modélisation de la population',...
             'Numbertitle','off',...
             'ToolBar','none',...
             'WindowState','maximized',...
             'Color',CM(5,:)/255);
colormap(CM/255);

[Size,Length] = size(Population);

Ver = [1 1;2 1;1 2;2 2];

VerE = [1 1;2 1;1 2;2 2];
FacE = [1 2 4 3];

axis('off','equal',[0 1.5*(Size+1) 0 Length+2]);
ax = gca;
ax.Position = [0 0 1 1];

CLK = char(datetime('now','Format',' yyyy-MM-dd HH-mm-ss'));
vid = VideoWriter(['vid',CLK,'.mp4'],'MPEG-4');
open(vid)

Logic = logical(Population);
PopulAnim = gobjects(Size,Length);
Tio = gobjects(Size,Length);
for x = 1:Size
    VerE(:,1) = Ver(1:4,1) + 1.5*(x-1);
    for y = 1:Length
        VerE(:,2) = Ver(1:4,2) + (y-1);
        CIndE = 4-Logic(x,y);
        
        GenomAnim = patch('Faces',FacE,...
                          'Vertices',VerE,...
                          'FaceVertexCData',CIndE,...
                          'FaceColor','flat',...
                          'CDataMapping','direct',...
                          'LineWidth',2,...
                          'EdgeColor',CM(1,:)/255);
        PopulAnim(x,y) = GenomAnim;
        
        Tio(x,y) = text((1.5*x),(y+0.5),'O',...
                        'Color',CM(1,:)/255,...
                        'HorizontalAlignment','center',...
                        'FontName','Cambria',...
                        'FontWeight','bold',...
                        'FontSize',16);
        if Logic(x,y)
            Tio(x,y).String = 'I';
        end
        
        if x==1
            img = getframe(ax);
            writeVideo(vid,repmat(img,1,1,1,4));
        end
    end
    if x~=1
        img = getframe(ax);
        writeVideo(vid,repmat(img,1,1,1,4));
    end
end

img = getframe(ax);
frame = img.cdata;
imwrite(frame,'Test_ga.png');

end